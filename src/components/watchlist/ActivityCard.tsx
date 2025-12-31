import { Link } from 'react-router-dom'
import type { ActivityItem } from '../../hooks/useWatchActivity'

interface ActivityCardProps {
  activity: ActivityItem
}

export function ActivityCard({ activity }: ActivityCardProps) {
  const formatDate = (dateString: string): string => {
    const date = new Date(dateString)
    const now = new Date()
    const diffMs = now.getTime() - date.getTime()
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))

    if (diffDays === 0) {
      return 'Today'
    } else if (diffDays === 1) {
      return 'Yesterday'
    } else if (diffDays < 7) {
      return `${diffDays} days ago`
    } else {
      return date.toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
      })
    }
  }

  const getActivityDescription = () => {
    if (activity.activityType === 'photo_tag') {
      return (
        <>
          <span className="font-semibold">{activity.personName}</span> was tagged in "{activity.title}"
        </>
      )
    } else {
      return (
        <>
          A memory was shared about <span className="font-semibold">{activity.personName}</span>
        </>
      )
    }
  }

  const getViewLink = () => {
    if (activity.activityType === 'photo_tag' && activity.photoId) {
      return (
        <Link
          to={`/photo/${activity.photoId}`}
          className="text-primary-600 hover:text-primary-700 hover:underline text-sm"
        >
          → View photo
        </Link>
      )
    } else if (activity.activityType === 'memory' && activity.memoryId) {
      return (
        <Link
          to={`/person/${activity.personId}`}
          className="text-primary-600 hover:text-primary-700 hover:underline text-sm"
        >
          → View memory
        </Link>
      )
    }
    return null
  }

  return (
    <div className="bg-white rounded-lg shadow-md p-4 border border-gray-200 hover:shadow-lg transition-shadow">
      <div className="flex items-start gap-3">
        <div className="text-2xl flex-shrink-0">
          {activity.activityType === 'photo_tag' ? '📷' : '💭'}
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center justify-between gap-2 mb-1">
            <span className="text-sm text-gray-500">{formatDate(activity.createdAt)}</span>
            {getViewLink()}
          </div>
          <p className="text-gray-700 mb-2">{getActivityDescription()}</p>
          {activity.activityType === 'memory' && (
            <p className="text-sm text-gray-600 italic">"{activity.title}"</p>
          )}
        </div>
      </div>
    </div>
  )
}
