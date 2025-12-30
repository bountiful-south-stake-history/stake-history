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

function App() {
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
          <Route path="/about" element={<AboutPage />} />
          <Route path="/admin" element={<AdminPage />} />
        </Routes>
      </Layout>
    </BrowserRouter>
  )
}

export default App

