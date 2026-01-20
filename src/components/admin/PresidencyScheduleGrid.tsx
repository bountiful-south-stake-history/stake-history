
interface Appointment {
  id: string
  name: string
  description?: string
  status: 'scheduled' | 'open' | 'continuation' | 'held' | 'no-show' | 'blocked'
  timeSlot: string
  personId: string
}

interface Person {
  id: string
  name: string
}

interface TimeSlot {
  time: string
  display: string
}

interface PresidencyScheduleGridProps {
  date: string
  people: Person[]
  appointments: Appointment[]
  timeSlots: TimeSlot[]
  onAppointmentClick?: (appointment: Appointment | null, timeSlot: string, personId: string) => void
}

export function PresidencyScheduleGrid({
  date,
  people,
  appointments,
  timeSlots,
  onAppointmentClick,
}: PresidencyScheduleGridProps) {
  const getAppointmentForSlot = (timeSlot: string, personId: string): Appointment | null => {
    return appointments.find(
      (apt) => apt.timeSlot === timeSlot && apt.personId === personId
    ) || null
  }

  const getAppointmentStatusClass = (status: Appointment['status']) => {
    switch (status) {
      case 'scheduled':
        return 'bg-green-50 border-green-300 border-2'
      case 'open':
        return 'bg-gray-100 border-gray-300 border-2 cursor-pointer hover:bg-gray-200'
      case 'continuation':
        return 'bg-green-50 border-green-300 border-2 border-dashed'
      case 'held':
        return 'bg-blue-50 border-blue-300 border-2'
      case 'no-show':
        return 'bg-yellow-50 border-yellow-300 border-2'
      case 'blocked':
        return 'bg-gray-200 border-gray-400 border-2'
      default:
        return 'bg-gray-100 border-gray-300 border-2'
    }
  }

  const handleSlotClick = (timeSlot: string, personId: string) => {
    const appointment = getAppointmentForSlot(timeSlot, personId)
    onAppointmentClick?.(appointment, timeSlot, personId)
  }

  return (
    <div className="w-full">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-gray-900 mb-2">Presidency Schedule</h2>
        <p className="text-gray-600">{new Date(date).toLocaleDateString('en-US', { 
          weekday: 'long', 
          year: 'numeric', 
          month: 'long', 
          day: 'numeric' 
        })}</p>
      </div>

      <div className="hidden md:block overflow-x-auto -mx-4 px-4 md:mx-0 md:px-0">
        <div className="min-w-[600px] md:min-w-0">
          <div className="bg-white rounded-lg shadow-md border border-gray-200 overflow-hidden">
            <div 
              className="grid grid-cols-[100px_repeat(var(--person-count),minmax(180px,1fr))]"
              style={{ '--person-count': people.length } as React.CSSProperties}
            >
              <div className="bg-gray-50 border-r border-gray-300 p-2 font-semibold text-sm text-gray-700">
                Time
              </div>
              {people.map((person) => (
                <div
                  key={person.id}
                  className="bg-gray-50 border-r border-gray-300 last:border-r-0 p-2 font-semibold text-sm text-gray-700 text-center"
                >
                  {person.name}
                </div>
              ))}
            </div>

            {timeSlots.map((slot) => (
              <div
                key={slot.time}
                className="grid grid-cols-[100px_repeat(var(--person-count),minmax(180px,1fr))] border-t border-gray-200"
                style={{ '--person-count': people.length } as React.CSSProperties}
              >
                <div className="bg-white border-r border-gray-300 p-2 text-sm text-gray-600 font-medium">
                  {slot.display}
                </div>
                {people.map((person) => {
                  const appointment = getAppointmentForSlot(slot.time, person.id)
                  const status = appointment?.status || 'open'

                  return (
                    <div
                      key={`${slot.time}-${person.id}`}
                      className="border-r border-gray-200 last:border-r-0 p-1 min-h-[80px]"
                    >
                      {appointment ? (
                        <div
                          className={`${getAppointmentStatusClass(status)} rounded p-2 h-full flex flex-col justify-center ${
                            status === 'open' ? 'cursor-pointer hover:bg-gray-200' : ''
                          }`}
                          onClick={() => status === 'open' && handleSlotClick(slot.time, person.id)}
                        >
                          {status === 'continuation' ? (
                            <div className="text-xs text-gray-600 text-center font-medium">Continuation</div>
                          ) : (
                            <>
                              <div className="font-medium text-base text-gray-900 mb-1 break-words">
                                {appointment.name}
                              </div>
                              {appointment.description && (
                                <div className="text-xs text-gray-600 mb-1 line-clamp-2">
                                  {appointment.description}
                                </div>
                              )}
                              <div className="text-xs text-green-600 mt-auto font-medium">
                                Scheduled
                              </div>
                            </>
                          )}
                        </div>
                      ) : (
                        <div
                          className={`${getAppointmentStatusClass('open')} rounded p-2 h-full flex flex-col items-center justify-center cursor-pointer hover:bg-gray-200`}
                          onClick={() => handleSlotClick(slot.time, person.id)}
                        >
                          <svg
                            className="w-6 h-6 text-gray-400 mb-1"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              strokeWidth={2}
                              d="M12 4v16m8-8H4"
                            />
                          </svg>
                          <div className="text-xs text-gray-600 font-medium">Open</div>
                        </div>
                      )}
                    </div>
                  )
                })}
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="md:hidden space-y-4">
        {timeSlots.map((slot) => (
          <div key={slot.time} className="bg-white rounded-lg shadow-md border border-gray-200 overflow-hidden">
            <div className="bg-gray-50 border-b border-gray-300 px-4 py-3">
              <h3 className="text-base font-semibold text-gray-900">{slot.display}</h3>
            </div>
            <div className="divide-y divide-gray-200">
              {people.map((person) => {
                const appointment = getAppointmentForSlot(slot.time, person.id)
                const status = appointment?.status || 'open'

                return (
                  <div
                    key={`${slot.time}-${person.id}`}
                    className="px-4 py-3"
                  >
                    <div className="mb-2">
                      <span className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        {person.name}
                      </span>
                    </div>
                    {appointment ? (
                      <div
                        className={`${getAppointmentStatusClass(status)} rounded-lg p-3 touch-manipulation ${
                          status === 'open' ? 'cursor-pointer active:scale-[0.98]' : ''
                        }`}
                        onClick={() => status === 'open' && handleSlotClick(slot.time, person.id)}
                      >
                        {status === 'continuation' ? (
                          <div className="text-sm text-gray-600 text-center font-medium">Continuation</div>
                        ) : (
                          <>
                            <div className="font-semibold text-base text-gray-900 mb-1 break-words">
                              {appointment.name}
                            </div>
                            {appointment.description && (
                              <div className="text-sm text-gray-600 mb-2">
                                {appointment.description}
                              </div>
                            )}
                            <div className="text-xs text-green-600 font-medium">
                              Scheduled
                            </div>
                          </>
                        )}
                      </div>
                    ) : (
                      <div
                        className={`${getAppointmentStatusClass('open')} rounded-lg p-3 flex items-center justify-center cursor-pointer touch-manipulation active:scale-[0.98] min-h-[60px]`}
                        onClick={() => handleSlotClick(slot.time, person.id)}
                      >
                        <div className="text-center">
                          <svg
                            className="w-6 h-6 text-gray-400 mb-1 mx-auto"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24"
                          >
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              strokeWidth={2}
                              d="M12 4v16m8-8H4"
                            />
                          </svg>
                          <div className="text-sm text-gray-600 font-medium">Open</div>
                        </div>
                      </div>
                    )}
                  </div>
                )
              })}
            </div>
          </div>
        ))}
      </div>

      <div className="mt-6 p-4 bg-gray-50 rounded-lg border border-gray-200">
        <h3 className="text-sm font-semibold text-gray-700 mb-3">Legend</h3>
        <div className="grid grid-cols-2 md:grid-cols-3 gap-3 text-xs">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-gray-100 border-2 border-gray-300 rounded"></div>
            <span className="text-gray-700">Open (click to book)</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-green-50 border-2 border-green-300 rounded"></div>
            <span className="text-gray-700">Scheduled</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-blue-50 border-2 border-blue-300 rounded"></div>
            <span className="text-gray-700">Held</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-yellow-50 border-2 border-yellow-300 rounded"></div>
            <span className="text-gray-700">No-Show</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-gray-200 border-2 border-gray-400 rounded"></div>
            <span className="text-gray-700">Blocked</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 bg-green-50 border-2 border-green-300 border-dashed rounded"></div>
            <span className="text-gray-700">Continuation</span>
          </div>
        </div>
      </div>
    </div>
  )
}
