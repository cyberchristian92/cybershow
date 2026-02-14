import React, { useEffect } from 'react';
import { motion } from 'framer-motion';
interface SplashScreenProps {
  onComplete: () => void;
}
export function SplashScreen({ onComplete }: SplashScreenProps) {
  useEffect(() => {
    const timer = setTimeout(() => {
      onComplete();
    }, 3500); // Slightly longer than 3s to allow exit animation to start naturally
    return () => clearTimeout(timer);
  }, [onComplete]);
  return (
    <motion.div
      className="fixed inset-0 z-50 flex flex-col items-center justify-center bg-cyber-bg overflow-hidden"
      initial={{
        opacity: 0
      }}
      animate={{
        opacity: 1
      }}
      exit={{
        opacity: 0,
        transition: {
          duration: 0.8
        }
      }}>

      {/* Background ambient glow */}
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-cyber-purple/20 via-cyber-bg to-cyber-bg opacity-50" />

      {/* Grid overlay effect */}
      <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-5 mix-blend-overlay" />

      <div className="relative z-10 flex flex-col items-center">
        <motion.div
          initial={{
            scale: 0.8,
            opacity: 0
          }}
          animate={{
            scale: 1,
            opacity: 1
          }}
          transition={{
            duration: 1.2,
            ease: 'easeOut',
            type: 'spring',
            bounce: 0.4
          }}
          className="relative mb-8">

          {/* Logo Glow */}
          <div className="absolute inset-0 bg-cyber-cyan blur-3xl opacity-20 animate-pulse-slow rounded-full" />

          {/* Logo Image */}
          <img
            src="/unnamed.jpg"
            alt="Cyber Show Logo"
            className="w-40 h-40 md:w-56 md:h-56 object-contain relative z-10 drop-shadow-[0_0_15px_rgba(0,240,255,0.5)]" />


          {/* Glitch overlay layers (simulated with CSS classes on parent if needed, but here we use the image) */}
        </motion.div>

        <motion.div
          initial={{
            y: 20,
            opacity: 0
          }}
          animate={{
            y: 0,
            opacity: 1
          }}
          transition={{
            delay: 0.8,
            duration: 0.8
          }}
          className="text-center">

          <h1
            className="font-orbitron text-4xl md:text-6xl font-black text-white tracking-wider glitch-text mb-2"
            data-text="CYBER SHOW"
            style={{
              textShadow: '0 0 10px rgba(0, 240, 255, 0.8)'
            }}>

            CYBER SHOW
          </h1>

          <motion.div
            className="h-1 w-0 bg-gradient-to-r from-cyber-cyan via-cyber-purple to-cyber-pink mx-auto mt-4 rounded-full"
            animate={{
              width: '100%'
            }}
            transition={{
              delay: 1.5,
              duration: 1,
              ease: 'easeInOut'
            }} />


          <motion.p
            initial={{
              opacity: 0
            }}
            animate={{
              opacity: 1
            }}
            transition={{
              delay: 2.2
            }}
            className="mt-4 text-cyber-cyan font-mono text-sm tracking-[0.3em] uppercase">

            System Initializing...
          </motion.p>
        </motion.div>
      </div>
    </motion.div>);

}