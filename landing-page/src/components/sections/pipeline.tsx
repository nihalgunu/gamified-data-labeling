import React from 'react';

const Pipeline = () => {
  return (
    <section className="py-24 bg-transparent">
      <div className="max-w-6xl mx-auto px-6">
        <h2 className="text-white text-5xl sm:text-6xl font-bold text-center mb-16">
          How It Works
        </h2>

        {/* Step 1 */}
        <div className="grid md:grid-cols-2 gap-12 items-center mb-24">
          <div className="order-2 md:order-1">
            <h3 className="text-white text-3xl sm:text-4xl font-bold mb-6">1 — Upload</h3>
            <p className="text-white/90 text-lg sm:text-xl leading-relaxed">
              Kick off your labeling project with a simple upload or direct integration
              from popular data sources. Our platform automatically prepares your files
              for seamless collaboration.
            </p>
          </div>
          <div className="order-1 md:order-2">
            <div className="bg-white/10 rounded-2xl p-1 transition-transform duration-300 hover:scale-105">
              <img
                src="/images/1.png"
                alt="Upload step"
                className="w-full rounded-xl"
              />
            </div>
          </div>
        </div>

        {/* Step 2 */}
        <div className="grid md:grid-cols-2 gap-12 items-center mb-24">
          <div>
            <div className="bg-white/10 rounded-2xl p-1 transition-transform duration-300 hover:scale-105">
              <img
                src="/images/2.png"
                alt="Define tasks"
                className="w-full rounded-xl"
              />
            </div>
          </div>
          <div>
            <h3 className="text-white text-3xl sm:text-4xl font-bold mb-6">2 — Define Tasks</h3>
            <p className="text-white/90 text-lg sm:text-xl leading-relaxed">
              Create classification, segmentation, or custom prompts. 
              Our flexible interface lets you tailor labeling workflows 
              to match your exact project needs.
            </p>
          </div>
        </div>

        {/* Step 3 */}
        <div className="grid md:grid-cols-2 gap-12 items-center mb-24">
          <div className="order-2 md:order-1">
            <h3 className="text-white text-3xl sm:text-4xl font-bold mb-6">3 — Engage Community</h3>
            <p className="text-white/90 text-lg sm:text-xl leading-relaxed">
              Tap into a global network of labelers who earn fair compensation 
              and enjoy a gamified experience—motivating accurate, high-quality results.
            </p>
          </div>
          <div className="order-1 md:order-2">
            <div className="bg-white/10 rounded-2xl p-1 transition-transform duration-300 hover:scale-105">
              <img
                src="/images/3.png"
                alt="Engage community"
                className="w-full rounded-xl"
              />
            </div>
          </div>
        </div>

        {/* Step 4 */}
        <div className="grid md:grid-cols-2 gap-12 items-center">
          <div>
            <div className="bg-white/10 rounded-2xl p-1 transition-transform duration-300 hover:scale-105">
              <img
                src="/images/4.png"
                alt="Monitor progress"
                className="w-full rounded-xl"
              />
            </div>
          </div>
          <div>
            <h3 className="text-white text-3xl sm:text-4xl font-bold mb-6">4 — Monitor & Refine</h3>
            <p className="text-white/90 text-lg sm:text-xl leading-relaxed">
              Track progress in real time with intuitive dashboards. 
              Validate and refine labeled data, ensuring top-tier quality 
              for all your projects.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Pipeline;