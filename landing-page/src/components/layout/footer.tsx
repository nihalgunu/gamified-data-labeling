import Link from 'next/link'

const footerLinks = {
  Platform: [
    { name: 'Features', href: '#features' },
    { name: 'For Companies', href: '#company' },
    { name: 'Pricing', href: '#pricing' },
    { name: 'FAQ', href: '#faq' }
  ],
  Company: [
    { name: 'About Us', href: '#about' },
    { name: 'Blog', href: '/blog' },
    { name: 'Careers', href: '/careers' },
    { name: 'Contact', href: '/contact' }
  ],
  Legal: [
    { name: 'Privacy Policy', href: '/privacy' },
    { name: 'Terms of Service', href: '/terms' },
    { name: 'Cookie Policy', href: '/cookies' }
  ]
}

export function Footer() {
  return (
    <footer className="bg-[var(--footer-background)] text-[var(--text-white)] px-6 py-12">
      <div className="max-w-6xl mx-auto grid md:grid-cols-4 gap-8">
        <div>
          <h3 className="text-xl font-bold mb-4">Summit</h3>
          <p className="text-[var(--text-white)]">
            Build ethical AI labeling pipelines in minutes with our no‑code platform.
          </p>
        </div>

        {Object.entries(footerLinks).map(([title, links]) => (
          <div key={title}>
            <h4 className="font-bold mb-4 text-[var(--text-white)]">{title}</h4>
            <ul className="space-y-2">
              {links.map((link) => (
                <li key={link.name}>
                  <Link 
                    href={link.href}
                    className="text-[var(--text-white)] hover:text-[var(--accent)] transition-colors"
                  >
                    {link.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        ))}
      </div>

      <div className="max-w-6xl mx-auto mt-8 pt-8 border-t border-[var(--accent)]">
        <div className="flex flex-col md:flex-row justify-between items-center gap-4 text-[var(--text-white)] text-sm">
          <p>© {new Date().getFullYear()} DataLabel. All rights reserved.</p>
          <div className="flex gap-4">
            <Link href="#" className="hover:text-[var(--accent)] transition-colors">
              Twitter
            </Link>
            <Link href="#" className="hover:text-[var(--accent)] transition-colors">
              LinkedIn
            </Link>
            <Link href="#" className="hover:text-[var(--accent)] transition-colors">
              GitHub
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
