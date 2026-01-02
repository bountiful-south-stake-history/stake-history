import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { Layout } from './components/layout/Layout'
import { HomePage } from './pages/HomePage'
import { PersonMemoriesPage } from './pages/PersonMemoriesPage'
import { OrganizationPage } from './pages/OrganizationPage'
import { SearchPage } from './pages/SearchPage'
import { AboutPage } from './pages/AboutPage'
import { AdminPage } from './pages/AdminPage'
import { PhotoAlbumPage } from './pages/PhotoAlbumPage'
import { PhotoDetailPage } from './pages/PhotoDetailPage'
import { MyWatchlistPage } from './pages/MyWatchlistPage'
import { ArchivesPage } from './pages/ArchivesPage'
import { FeatureAnnouncementModal } from './components/announcements/FeatureAnnouncementModal'
import { useFeatureAnnouncements } from './hooks/useFeatureAnnouncements'

function App() {
  const { showWatchFeature, dismissWatchFeature, isChecking } = useFeatureAnnouncements()

  return (
    <BrowserRouter>
      <Layout>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/person/:id" element={<PersonMemoriesPage />} />
          <Route path="/org/:id" element={<OrganizationPage />} />
          <Route path="/search" element={<SearchPage />} />
          <Route path="/photos" element={<PhotoAlbumPage />} />
          <Route path="/photo/:photoId" element={<PhotoDetailPage />} />
          <Route path="/my-watchlist" element={<MyWatchlistPage />} />
          <Route path="/archives" element={<ArchivesPage />} />
          <Route path="/about" element={<AboutPage />} />
          <Route path="/admin" element={<AdminPage />} />
        </Routes>
        {!isChecking && showWatchFeature && (
          <FeatureAnnouncementModal onClose={dismissWatchFeature} />
        )}
      </Layout>
    </BrowserRouter>
  )
}

export default App

