"use client";

import React, { useState } from 'react';
import { Badge } from '@/components/ui/badge';
import { Award, Database, Image, Loader2, Plus, FolderPlus, Code } from 'lucide-react';
import Link from 'next/link';

interface ImageLink {
  filename: string;
  driveId: string;
  link: string;
  uploadDate: Date;
}

interface UploadedFolder {
  folderName: string;
  uploadDate: Date;
  images: ImageLink[];
  reviewsPerImage: number;
  targetedDemographic: string;
  classificationType: string;
}

const PlatformPage = () => {
  const [activeTab, setActiveTab] = useState('tasks');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isProjectModalOpen, setIsProjectModalOpen] = useState(false);
  const [reviewsPerImage, setReviewsPerImage] = useState('');
  const [targetedDemographic, setTargetedDemographic] = useState('None');
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [uploadedFolders, setUploadedFolders] = useState<UploadedFolder[]>([]);
  const [classificationType, setClassificationType] = useState('Classification');
  const [isUploading, setIsUploading] = useState(false);
  const [selectedFolder, setSelectedFolder] = useState<UploadedFolder | null>(null);

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (event.target.files) {
      setSelectedFile(event.target.files[0]);
    }
  };

  const handleUpload = async () => {
    if (selectedFile) {
      try {
        setIsUploading(true);

        const formData = new FormData();
        formData.append('file', selectedFile);
        formData.append('reviewsPerImage', reviewsPerImage);
        formData.append('targetedDemographic', targetedDemographic);
        formData.append('classificationType', classificationType);

        const response = await fetch('/api/uploads', {
          method: 'POST',
          body: formData,
        });

        if (!response.ok) {
          throw new Error('Upload failed');
        }

        const data = await response.json();

        const newFolder: UploadedFolder = {
          folderName: selectedFile.name,
          uploadDate: new Date(),
          images: data.data.images,
          reviewsPerImage: parseInt(reviewsPerImage),
          targetedDemographic,
          classificationType,
        };

        setUploadedFolders((prev) => [...prev, newFolder]);
        setIsModalOpen(false);
        setSelectedFile(null);
        setReviewsPerImage('');
        setTargetedDemographic('None');
        setClassificationType('Classification');

        alert('Upload successful!');
      } catch (error) {
        console.error('Upload error:', error);
        alert('Failed to upload file. Please try again.');
      } finally {
        setIsUploading(false);
      }
    }
  };

  return (
    <div className="min-h-screen overflow-y-auto mountain-bg">
      {/* 1) NAVBAR ABOVE THE PROGRESS BAR, matching the rest of the app */}
      <header className="bg-white/10 backdrop-blur-sm border-b border-white/10">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex justify-between items-center">
            <div className="flex items-center space-x-4">
              <h1 className="text-2xl font-medium text-white">DataLabel Platform</h1>
              <Badge variant="secondary" className="bg-white/20 text-white">
                Beta
              </Badge>
            </div>
            <nav className="flex items-center space-x-6">
              <button
                className={`px-4 py-2 rounded-full transition-all ${
                  activeTab === 'tasks'
                    ? 'bg-white/20 text-white'
                    : 'text-white/70 hover:text-white'
                }`}
                onClick={() => setActiveTab('tasks')}
              >
                Tasks
              </button>
              <button
                className={`px-4 py-2 rounded-full transition-all ${
                  activeTab === 'upload'
                    ? 'bg-white/20 text-white'
                    : 'text-white/70 hover:text-white'
                }`}
                onClick={() => setIsModalOpen(true)}
              >
                Upload
              </button>
              <Link
                href="/api/auth/logout"
                className="px-4 py-2 rounded-full text-white/70 hover:text-white transition-all"
              >
                Logout
              </Link>
            </nav>
          </div>
        </div>
      </header>

      {/* 2) LARGE PROGRESS BAR SECTION WITH DIAGONAL STRIPES */}
      <div className="bg-white/10 backdrop-blur-sm border-b border-white/10 py-20">
        <div className="max-w-7xl mx-auto px-6">
          <div className="flex flex-col items-center space-y-8">
            {/* Outer bar */}
            <div className="w-full h-6 bg-white/10 rounded-full overflow-hidden">
              {/* Filled portion with slanted lines */}
              <div
                className="h-full rounded-full transition-all duration-500"
                style={{
                  width: '65%',
                  backgroundImage: `
                    repeating-linear-gradient(
                      45deg,
                      rgba(29,78,216,0.8) 0,
                      rgba(29,78,216,0.8) 10px,
                      rgba(59,130,246,0.8) 10px,
                      rgba(59,130,246,0.8) 20px
                    )
                  `,
                }}
              />
            </div>

            <div className="text-white text-2xl font-medium">65/100 Tasks Completed</div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-6 py-12">
        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          {[
            { icon: Award, title: 'Accuracy Score', value: '98.5%', subtitle: 'Last 30 days' },
            { icon: Database, title: 'Tasks Completed', value: '1,234', subtitle: 'Total contributions' },
            { icon: Image, title: 'Available Tasks', value: '89', subtitle: 'Ready to label' },
          ].map((stat, index) => (
            <div
              key={index}
              className="bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20"
            >
              <div className="flex items-center space-x-3 mb-4">
                <stat.icon className="w-5 h-5 text-white/70" />
                <h3 className="text-lg font-medium text-white">{stat.title}</h3>
              </div>
              <p className="text-3xl font-bold text-white mb-1">{stat.value}</p>
              <p className="text-sm text-white/70">{stat.subtitle}</p>
            </div>
          ))}
        </div>

        {/* Projects Section */}
        <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20 mb-8">
          <h2 className="text-xl font-medium text-white mb-6">Your Projects</h2>
          {/* Only 3 columns on large screens, big cards */}
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {/* CREATE NEW PROJECT CARD (massive) */}
            <div
              onClick={() => setIsProjectModalOpen(true)}
              className="bg-white/5 cursor-pointer rounded-2xl border-2 border-white/20 
                         p-10 h-60 flex flex-col items-center justify-center text-center
                         hover:bg-white/10 transition-all"
            >
              <Plus className="w-10 h-10 text-white mb-3" />
              <span className="text-white text-xl font-bold">Create a project</span>
            </div>

            {/* Preset #1 */}
            <div className="bg-white/5 rounded-2xl border-2 border-white/20 
                            p-10 h-60 flex flex-col items-center justify-center text-center
                            hover:bg-white/10 transition-all"
            >
              <h3 className="text-white text-xl font-bold mb-2">Image Classification</h3>
              <p className="text-white/70 text-sm">15 datasets • 3 models</p>
            </div>

            {/* Preset #2 */}
            <div className="bg-white/5 rounded-2xl border-2 border-white/20 
                            p-10 h-60 flex flex-col items-center justify-center text-center
                            hover:bg-white/10 transition-all"
            >
              <h3 className="text-white text-xl font-bold mb-2">Object Detection</h3>
              <p className="text-white/70 text-sm">8 datasets • 2 models</p>
            </div>

            {/* Preset #3 */}
            <div className="bg-white/5 rounded-2xl border-2 border-white/20 
                            p-10 h-60 flex flex-col items-center justify-center text-center
                            hover:bg-white/10 transition-all"
            >
              <h3 className="text-white text-xl font-bold mb-2">Semantic Segmentation</h3>
              <p className="text-white/70 text-sm">12 datasets • 5 models</p>
            </div>

            {/* Preset #4 */}
            <div className="bg-white/5 rounded-2xl border-2 border-white/20 
                            p-10 h-60 flex flex-col items-center justify-center text-center
                            hover:bg-white/10 transition-all"
            >
              <h3 className="text-white text-xl font-bold mb-2">Data Labeling QA</h3>
              <p className="text-white/70 text-sm">9 datasets • 1 model</p>
            </div>
          </div>
        </div>

        {/* Folders Uploaded Section */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="md:col-span-3">
            <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20">
              <h2 className="text-xl font-medium text-white mb-6">Folders Uploaded</h2>
              <div className="space-y-4">
                {uploadedFolders.map((folder, index) => (
                  <div
                    key={index}
                    className={`bg-white/5 hover:bg-white/10 rounded-xl p-4 cursor-pointer transition-all border border-white/10 ${
                      folder.folderName === selectedFolder?.folderName ? 'border-white/40' : ''
                    }`}
                    onClick={() => setSelectedFolder(folder)}
                  >
                    <div className="flex justify-between items-center">
                      <div>
                        <h3 className="text-white font-medium">{folder.folderName}</h3>
                        <p className="text-white/70 text-sm">
                          {folder.images.length} images • Uploaded{' '}
                          {new Date(folder.uploadDate).toLocaleDateString()}
                        </p>
                      </div>
                      <Badge variant="secondary" className="bg-white/20">
                        {folder.classificationType}
                      </Badge>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {selectedFolder && (
            <div className="md:col-span-3">
              <div className="bg-white/10 backdrop-blur-sm rounded-2xl p-6 border border-white/20">
                <div className="flex justify-between items-center mb-6">
                  <h2 className="text-xl font-medium text-white">
                    {selectedFolder.folderName} - Images
                  </h2>
                  <Badge variant="secondary" className="bg-white/20">
                    {selectedFolder.targetedDemographic} • {selectedFolder.reviewsPerImage} reviews/image
                  </Badge>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4">
                  {selectedFolder.images.map((image, index) => (
                    <a
                      key={index}
                      href={image.link}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="block bg-white/5 rounded-lg p-3 hover:bg-white/10 transition-all"
                    >
                      <div className="text-white text-sm truncate">{image.filename}</div>
                      <div className="text-white/50 text-xs mt-1">
                        {new Date(image.uploadDate).toLocaleDateString()}
                      </div>
                    </a>
                  ))}
                </div>
              </div>
            </div>
          )}
        </div>
      </main>

      {/* Upload Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/50 backdrop-blur-sm">
          <div className="bg-white/20 backdrop-blur-md rounded-2xl p-8 border border-white/20 w-[480px] text-white">
            <h2 className="text-xl font-medium mb-6">Upload Files</h2>

            <div className="space-y-6">
              <div>
                <input
                  type="file"
                  accept=".zip"
                  onChange={handleFileChange}
                  disabled={isUploading}
                  className="block w-full text-sm text-white/70
                    file:mr-4 file:py-2 file:px-4
                    file:rounded-full file:border-0
                    file:text-sm file:font-medium
                    file:bg-white/10 file:text-white
                    hover:file:bg-white/20"
                />
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">Reviews per Image</label>
                <input
                  type="number"
                  value={reviewsPerImage}
                  onChange={(e) => setReviewsPerImage(e.target.value)}
                  disabled={isUploading}
                  className="w-full bg-white/10 rounded-lg px-4 py-2 text-white placeholder-white/50 border border-white/20"
                />
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">Targeted Demographic</label>
                <select
                  value={targetedDemographic}
                  onChange={(e) => setTargetedDemographic(e.target.value)}
                  disabled={isUploading}
                  className="w-full bg-white/10 rounded-lg px-4 py-2 text-black border border-white/20"
                >
                  {['All', 'School graduates', 'College Graduates', 'Working Adults'].map((option) => (
                    <option key={option} value={option}>
                      {option}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium mb-2">Classification Type</label>
                <select
                  value={classificationType}
                  onChange={(e) => setClassificationType(e.target.value)}
                  disabled={isUploading}
                  className="w-full bg-white/10 rounded-lg px-4 py-2 text-white border border-white/20"
                >
                  {['Classification', 'Segmentation'].map((option) => (
                    <option key={option} value={option}>
                      {option}
                    </option>
                  ))}
                </select>
              </div>

              <div className="flex justify-end space-x-4 mt-8">
                <button
                  onClick={() => setIsModalOpen(false)}
                  disabled={isUploading}
                  className="px-6 py-2 rounded-full bg-white/10 text-white hover:bg-white/20 transition-all disabled:opacity-50"
                >
                  Cancel
                </button>
                <button
                  onClick={handleUpload}
                  disabled={isUploading}
                  className="px-6 py-2 rounded-full bg-white/20 text-white hover:bg-white/30 transition-all disabled:opacity-50 flex items-center space-x-2"
                >
                  {isUploading ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      <span>Uploading...</span>
                    </>
                  ) : (
                    <span>Upload</span>
                  )}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* New Project Modal */}
      {isProjectModalOpen && (
        <div className="fixed inset-0 flex items-center justify-center bg-black/50 backdrop-blur-sm">
          <div className="bg-white/20 backdrop-blur-md rounded-2xl p-8 border border-white/20 w-[480px] text-white">
            <h2 className="text-xl font-medium mb-6">Create New Project</h2>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <button
                onClick={() => {
                  setIsProjectModalOpen(false);
                  setIsModalOpen(true);
                }}
                className="flex flex-col items-center justify-center p-6 bg-white/10 rounded-xl hover:bg-white/20 transition-all border border-white/20"
              >
                <FolderPlus className="w-8 h-8 text-white mb-3" />
                <span className="text-white font-medium">Add Dataset</span>
                <p className="text-white/70 text-sm text-center mt-2">
                  Upload new data for labeling
                </p>
              </button>

              <button
                onClick={() => {
                  setIsProjectModalOpen(false);
                  // Add model modal logic here
                }}
                className="flex flex-col items-center justify-center p-6 bg-white/10 rounded-xl hover:bg-white/20 transition-all border border-white/20"
              >
                <Code className="w-8 h-8 text-white mb-3" />
                <span className="text-white font-medium">Add Model</span>
                <p className="text-white/70 text-sm text-center mt-2">
                  Configure a new model
                </p>
              </button>
            </div>

            <div className="flex justify-end mt-6">
              <button
                onClick={() => setIsProjectModalOpen(false)}
                className="px-6 py-2 rounded-full bg-white/10 text-white hover:bg-white/20 transition-all"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default PlatformPage;