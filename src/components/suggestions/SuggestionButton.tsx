import { useState } from 'react'
import { FaLightbulb } from 'react-icons/fa'
import { SuggestionModal } from './SuggestionModal'

export function SuggestionButton() {
  const [modalOpen, setModalOpen] = useState(false)

  return (
    <>
      <button
        onClick={() => setModalOpen(true)}
        className="fixed bottom-6 right-6 z-40 flex items-center gap-2 px-4 py-2.5 bg-accent-500 hover:bg-accent-600 text-white rounded-full shadow-lg transition-colors font-medium text-sm"
        aria-label="Share a suggestion"
      >
        <FaLightbulb className="text-base" />
        <span>Suggestion</span>
      </button>

      {modalOpen && <SuggestionModal onClose={() => setModalOpen(false)} />}
    </>
  )
}
