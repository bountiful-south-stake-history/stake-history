import { useState, useMemo } from 'react'
import { useAdminStats } from '../../hooks/useAdminStats'
import { AdminPortraitsTab } from './AdminPortraitsTab'
import { AdminCorrectionsTab } from './AdminCorrectionsTab'
import { AdminMemoriesTab } from './AdminMemoriesTab'
import { AdminPhotosTab } from './AdminPhotosTab'
import { AdminPeopleTab } from './AdminPeopleTab'
import { AdminCallingsTab } from './AdminCallingsTab'
import { AdminTransitionsTab } from './AdminTransitionsTab'
import { AdminUsersTab } from './AdminUsersTab'

type AdminTab = 'portraits' | 'corrections' | 'memories' | 'photos' | 'people' | 'callings' | 'transitions' | 'users'

export function AdminDashboard() {
  const [activeTab, setActiveTab] = useState<AdminTab>('portraits')
  const { stats, loading: statsLoading, refetch: refetchStats } = useAdminStats()

  const tabs: { id: AdminTab; baseLabel: string; count?: number }[] = useMemo(() => [
    { id: 'portraits' as AdminTab, baseLabel: 'Portraits', count: stats.pendingPortraits },
    { id: 'corrections' as AdminTab, baseLabel: 'Corrections', count: stats.pendingCorrections },
    { id: 'memories' as AdminTab, baseLabel: 'Memories', count: stats.pendingMemories },
    { id: 'photos' as AdminTab, baseLabel: 'Photos', count: stats.pendingPhotos },
    { id: 'people' as AdminTab, baseLabel: 'Fix Names' },
    { id: 'callings' as AdminTab, baseLabel: 'Fix Dates' },
    { id: 'transitions' as AdminTab, baseLabel: 'Manage Callings' },
    { id: 'users' as AdminTab, baseLabel: 'Admins' },
  ], [stats])

  return (
    <div>
      <h1 className="text-3xl font-bold text-primary-700 mb-6">Admin Dashboard</h1>

      <div className="border-b border-gray-200 mb-6">
        <div className="flex gap-2 overflow-x-auto">
          {tabs.map((tab) => {
            const showCount = tab.count !== undefined && tab.count > 0 && !statsLoading
            
            return (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
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

