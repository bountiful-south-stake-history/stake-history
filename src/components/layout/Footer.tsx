export function Footer() {
  return (
    <footer className="bg-primary-600 text-white mt-auto">
      <div className="container mx-auto px-4 py-6">
        <div className="flex flex-col md:flex-row justify-between items-center gap-4">
          <p className="text-sm">
            © {new Date().getFullYear()} Bountiful Utah South Stake
          </p>
          <p className="text-sm text-gray-300">
            Historical records from 1958 to present
          </p>
        </div>
      </div>
    </footer>
  )
}

