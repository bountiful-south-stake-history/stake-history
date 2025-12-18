import { useState, useMemo, useRef, useEffect } from 'react'
import { useAdminStats } from '../../hooks/useAdminStats'
import { AdminPortraitsTab } from './AdminPortraitsTab'
import { AdminCorrectionsTab } from './AdminCorrectionsTab'
import { AdminMemoriesTab } from './AdminMemoriesTab'
import { AdminPhotosTab } from './AdminPhotosTab'
import { AdminPeopleTab } from './AdminPeopleTab'
import { AdminCallingsTab } from './AdminCallingsTab'
import { AdminTransitionsTab } from './AdminTransitionsTab'
import { AdminUsersTab } from './AdminUsersTab'

type MainTab = 'portraits' | 'corrections' | 'memories' | 'photos'
type ToolsTab = 'people' | 'callings' | 'transitions' | 'users'
type AdminTab = MainTab | ToolsTab

export function AdminDashboard() {
  const [activeTab, setActiveTab] = useState<AdminTab>('portraits')
  const [toolsDropdownOpen, setToolsDropdownOpen] = useState(false)
  const toolsDropdownRef = useRef<HTMLDivElement>(null)
  const { stats, loading: statsLoading, refetch: refetchStats } = useAdminStats()

  const mainTabs: { id: MainTab; baseLabel: string; count?: number }[] = useMemo(() => [
    { id: 'portraits' as MainTab, baseLabel: 'Portraits', count: stats.pendingPortraits },
    { id: 'corrections' as MainTab, baseLabel: 'Corrections', count: stats.pendingCorrections },
    { id: 'memories' as MainTab, baseLabel: 'Memories', count: stats.pendingMemories },
    { id: 'photos' as MainTab, baseLabel: 'Photos', count: stats.pendingPhotos },
  ], [stats])

  const toolsTabs: { id: ToolsTab; baseLabel: string }[] = [
    { id: 'people', baseLabel: 'Fix Names' },
    { id: 'callings', baseLabel: 'Fix Dates' },
    { id: 'transitions', baseLabel: 'Manage Callings' },
    { id: 'users', baseLabel: 'Users' },
  ]

  const isToolsTabActive = ['people', 'callings', 'transitions', 'users'].includes(activeTab)

  useEffect(() => {
    function handleClickOutside(event: MouseEvent | TouchEvent) {
      if (toolsDropdownRef.current && !toolsDropdownRef.current.contains(event.target as Node)) {
        setToolsDropdownOpen(false)
      }
    }

    if (toolsDropdownOpen) {
      setTimeout(() => {
        document.addEventListener('mousedown', handleClickOutside)
        document.addEventListener('touchstart', handleClickOutside)
      }, 100)
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
      document.removeEventListener('touchstart', handleClickOutside)
    }
  }, [toolsDropdownOpen])

  const handleToolsTabClick = (tabId: ToolsTab) => {
    setActiveTab(tabId)
    setToolsDropdownOpen(false)
  }

  return (
    <div>
      <h1 className="text-3xl font-bold text-primary-700 mb-6">Admin Dashboard</h1>

      <div className="border-b border-gray-200 mb-6">
        <div className="flex flex-col md:flex-row gap-2">
          <div className="flex gap-2 flex-wrap md:flex-nowrap">
            {mainTabs.slice(0, 3).map((tab) => {
              const showCount = tab.count !== undefined && tab.count > 0 && !statsLoading
              
              return (
                <button
                  key={tab.id}
                  onClick={() => {
                    setActiveTab(tab.id)
                    setToolsDropdownOpen(false)
                  }}
                  className={`px-4 py-2 font-medium border-b-2 transition-colors whitespace-nowrap ${
                    activeTab === tab.id
                      ? 'border-primary-600 text-primary-700'
                      : 'border-transparent text-gray-500 hover:text-gray-700'
                  }`}
                >
                  {tab.baseLabel}
                  {showCount && (
                    <span className="font-semibold text-primary-600 ml-1">({tab.count})</span>
                  )}
                </button>
              )
            })}
          </div>

          <div className="flex gap-2 flex-wrap md:flex-nowrap">
            {mainTabs.slice(3).map((tab) => {
              const showCount = tab.count !== undefined && tab.count > 0 && !statsLoading
              
              return (
                <button
                  key={tab.id}
                  onClick={() => {
                    setActiveTab(tab.id)
                    setToolsDropdownOpen(false)
                  }}
                  className={`px-4 py-2 font-medium border-b-2 transition-colors whitespace-nowrap ${
                    activeTab === tab.id
                      ? 'border-primary-600 text-primary-700'
                      : 'border-transparent text-gray-500 hover:text-gray-700'
                  }`}
                >
                  {tab.baseLabel}
                  {showCount && (
                    <span className="font-semibold text-primary-600 ml-1">({tab.count})</span>
                  )}
                </button>
              )
            })}

            <div className="relative" ref={toolsDropdownRef}>
              <button
                onClick={() => setToolsDropdownOpen(!toolsDropdownOpen)}
                className={`px-4 py-2 font-medium border-b-2 transition-colors whitespace-nowrap flex items-center gap-1 ${
                  isToolsTabActive
                    ? 'border-primary-600 text-primary-700'
                    : 'border-transparent text-gray-500 hover:text-gray-700'
                }`}
              >
                Tools
                <svg
                  className={`w-4 h-4 transition-transform ${toolsDropdownOpen ? 'rotate-180' : ''}`}
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </button>

              {toolsDropdownOpen && (
                <div className="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-50">
                  {toolsTabs.map((tab) => (
                    <button
                      key={tab.id}
                      onClick={() => handleToolsTabClick(tab.id)}
                      className={`w-full text-left px-4 py-2 text-sm transition-colors ${
                        activeTab === tab.id
                          ? 'bg-primary-50 text-primary-700 font-medium'
                          : 'text-gray-700 hover:bg-gray-100'
                      }`}
                    >
                      {tab.baseLabel}
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      <div>
        {activeTab === 'portraits' && <AdminPortraitsTab onActionComplete={refetchStats} />}
        {activeTab === 'corrections' && <AdminCorrectionsTab onActionComplete={refetchStats} />}
        {activeTab === 'memories' && <AdminMemoriesTab onActionComplete={refetchStats} />}
        {activeTab === 'photos' && <AdminPhotosTab onActionComplete={refetchStats} />}
        {activeTab === 'people' && <AdminPeopleTab onActionComplete={refetchStats} />}
        {activeTab === 'callings' && <AdminCallingsTab onActionComplete={refetchStats} />}
        {activeTab === 'transitions' && <AdminTransitionsTab onActionComplete={refetchStats} />}
        {activeTab === 'users' && <AdminUsersTab />}
      </div>
    </div>
  )
}

