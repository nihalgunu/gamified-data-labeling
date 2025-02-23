import Link from 'next/link'

export function Navbar() {
  return (
    <nav className="fixed w-full top-0 z-50 px-6 py-4">
      <div className="max-w-7xl mx-auto flex justify-between items-center">
        <Link href="/" className="text-white/90 text-xl font-medium">
          Summit
        </Link>
        <div className="flex items-center gap-8">
          <Link href="#features" className="text-white/75 hover:text-white text-sm transition-colors">
            Features
          </Link>
          <Link href="#company" className="text-white/75 hover:text-white text-sm transition-colors">
            For Companies
          </Link>
          <Link href="#mission" className="text-white/75 hover:text-white text-sm transition-colors">
            Mission
          </Link>
          <Link 
            href="/api/auth/login" 
            className="px-4 py-1.5 bg-white/10 rounded-full text-sm text-white hover:bg-white/20 transition-all"
          >
            Login
          </Link>
        </div>
      </div>
    </nav>
  );
}
