import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
  Gamepad2,
  Users,
  Shield,
  ChevronRight,
  ChevronLeft } from
'lucide-react';
interface OnboardingScreenProps {
  onComplete: () => void;
}
const slides = [
{
  id: 1,
  icon: Gamepad2,
  title: 'Aprenda Jogando',
  description:
  'Desafie seus conhecimentos em quizzes interativos e construa sua carreira em cibersegurança de forma divertida e envolvente.',
  color: 'text-cyber-cyan',
  glow: 'shadow-neon-cyan'
},
{
  id: 2,
  icon: Users,
  title: 'Conecte-se',
  description:
  'Faça parte de uma comunidade engajada. Compartilhe conquistas, troque experiências e aprenda com outros profissionais da área.',
  color: 'text-cyber-purple',
  glow: 'shadow-neon-purple'
},
{
  id: 3,
  icon: Shield,
  title: 'Segurança para Todos',
  description:
  'Promovemos inclusão digital e acessibilidade. Acreditamos que a cibersegurança é um direito fundamental de todos.',
  color: 'text-cyber-pink',
  glow: 'shadow-neon-pink'
}];

export function OnboardingScreen({ onComplete }: OnboardingScreenProps) {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [direction, setDirection] = useState(0);
  const nextSlide = () => {
    if (currentSlide < slides.length - 1) {
      setDirection(1);
      setCurrentSlide((prev) => prev + 1);
    } else {
      onComplete();
    }
  };
  const prevSlide = () => {
    if (currentSlide > 0) {
      setDirection(-1);
      setCurrentSlide((prev) => prev - 1);
    }
  };
  const goToSlide = (index: number) => {
    setDirection(index > currentSlide ? 1 : -1);
    setCurrentSlide(index);
  };
  const variants = {
    enter: (direction: number) => ({
      x: direction > 0 ? 1000 : -1000,
      opacity: 0,
      scale: 0.8
    }),
    center: {
      zIndex: 1,
      x: 0,
      opacity: 1,
      scale: 1
    },
    exit: (direction: number) => ({
      zIndex: 0,
      x: direction < 0 ? 1000 : -1000,
      opacity: 0,
      scale: 0.8
    })
  };
  const CurrentIcon = slides[currentSlide].icon;
  return (
    <motion.div
      className="min-h-screen w-full bg-cyber-bg flex flex-col items-center justify-between py-8 px-4 relative overflow-hidden"
      initial={{
        opacity: 0
      }}
      animate={{
        opacity: 1
      }}
      exit={{
        opacity: 0
      }}>

      {/* Background ambient light based on current slide color */}
      <motion.div
        className={`absolute inset-0 opacity-20 transition-colors duration-700 ease-in-out bg-gradient-to-b from-transparent to-cyber-bg`}
        style={{
          background: `radial-gradient(circle at 50% 30%, ${currentSlide === 0 ? '#00f0ff' : currentSlide === 1 ? '#a855f7' : '#ec4899'}33, transparent 70%)`
        }} />


      {/* Top Bar */}
      <div className="w-full flex justify-between items-center relative z-10 max-w-md">
        <img
          src="/unnamed.jpg"
          alt="Logo"
          className="w-8 h-8 object-contain" />

        <button
          onClick={onComplete}
          className="text-gray-500 text-sm font-medium hover:text-white transition-colors">

          Pular
        </button>
      </div>

      {/* Main Content Carousel */}
      <div className="flex-1 flex items-center justify-center w-full max-w-md relative">
        <AnimatePresence initial={false} custom={direction} mode="wait">
          <motion.div
            key={currentSlide}
            custom={direction}
            variants={variants}
            initial="enter"
            animate="center"
            exit="exit"
            transition={{
              x: {
                type: 'spring',
                stiffness: 300,
                damping: 30
              },
              opacity: {
                duration: 0.2
              }
            }}
            className="flex flex-col items-center text-center w-full absolute px-4">

            <div
              className={`w-32 h-32 rounded-full bg-cyber-input border border-white/10 flex items-center justify-center mb-8 relative group`}>

              {/* Icon Glow Ring */}
              <div
                className={`absolute inset-0 rounded-full opacity-50 blur-xl ${currentSlide === 0 ? 'bg-cyber-cyan' : currentSlide === 1 ? 'bg-cyber-purple' : 'bg-cyber-pink'}`} />


              <CurrentIcon
                className={`w-16 h-16 relative z-10 ${slides[currentSlide].color} drop-shadow-[0_0_10px_rgba(255,255,255,0.3)]`} />

            </div>

            <h2 className="font-orbitron text-2xl md:text-3xl font-bold text-white mb-4">
              {slides[currentSlide].title}
            </h2>

            <p className="text-gray-400 leading-relaxed max-w-xs mx-auto">
              {slides[currentSlide].description}
            </p>
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Bottom Controls */}
      <div className="w-full max-w-md flex flex-col items-center gap-8 relative z-10">
        {/* Dots */}
        <div className="flex space-x-3">
          {slides.map((_, index) =>
          <button
            key={index}
            onClick={() => goToSlide(index)}
            className={`h-2 rounded-full transition-all duration-300 ${currentSlide === index ? `w-8 ${index === 0 ? 'bg-cyber-cyan' : index === 1 ? 'bg-cyber-purple' : 'bg-cyber-pink'} shadow-[0_0_10px_currentColor]` : 'w-2 bg-gray-700 hover:bg-gray-600'}`}
            aria-label={`Go to slide ${index + 1}`} />

          )}
        </div>

        {/* Action Button */}
        <div className="w-full flex items-center justify-between px-4">
          <button
            onClick={prevSlide}
            disabled={currentSlide === 0}
            className={`p-3 rounded-full border border-gray-800 transition-all ${currentSlide === 0 ? 'opacity-0 pointer-events-none' : 'text-gray-400 hover:text-white hover:border-gray-600 hover:bg-white/5'}`}>

            <ChevronLeft className="w-6 h-6" />
          </button>

          <button
            onClick={nextSlide}
            className={`flex items-center justify-center py-3 px-8 rounded-full font-bold text-white transition-all transform hover:scale-105 active:scale-95 shadow-lg ${currentSlide === slides.length - 1 ? 'bg-gradient-to-r from-cyber-cyan to-cyber-purple shadow-[0_0_20px_rgba(0,240,255,0.4)]' : 'bg-cyber-input border border-gray-700 hover:border-gray-500'}`}>

            {currentSlide === slides.length - 1 ?
            <span className="flex items-center">
                COMEÇAR <ChevronRight className="ml-2 w-5 h-5" />
              </span> :

            <ChevronRight className="w-6 h-6" />
            }
          </button>
        </div>
      </div>
    </motion.div>);

}