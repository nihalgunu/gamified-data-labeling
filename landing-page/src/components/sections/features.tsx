import Image from 'next/image'
import { Globe, Shield, Users } from 'lucide-react'

const features = [
  {
    title: 'Global Community',
    description: 'Connect with a worldwide network of data labelers who share your commitment to quality and ethics.',
    icon: Globe
  },
  {
    title: 'Fair Compensation',
    description: 'We ensure all contributors are fairly compensated for their valuable work through our transparent payment system.',
    icon: Shield
  },
  {
    title: 'Gamified Experience',
    description: 'Earn points, unlock achievements, and compete with others while contributing to meaningful projects.',
    icon: Users
  }
]

export function Features() {
  return (
    <section className="relative py-16">
      <div className="container mx-auto px-4">
        <div className="grid md:grid-cols-2 gap-12 items-start">
          {/* Left Side: Features */}
          <div className="space-y-6">
            <h2 className="text-3xl font-bold mb-8 text-white">User Experience</h2>
            <div className="space-y-6">
              {features.map((feature) => (
                <div
                  key={feature.title}
                  className="bg-white/10 backdrop-blur-lg rounded-xl shadow-lg p-6 transition-all duration-300 hover:shadow-xl"
                >
                  <div className="flex items-start gap-4">
                    <div className="shrink-0">
                      <feature.icon className="h-6 w-6 text-teal-400" />
                    </div>
                    <div>
                      <h3 className="text-xl font-semibold mb-2 text-white">
                        {feature.title}
                      </h3>
                      <p className="text-white/90 leading-relaxed">
                        {feature.description}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Right Side: Single Image with Both Phones */}
          <div className="">
            <div className="">
              <img
                src="/images/iphone.jpg"
                alt="App Interface Screenshots"
                className=""
              />
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}