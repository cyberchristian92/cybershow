import React from 'react';
import { motion } from 'framer-motion';
import { Shield, Play, ArrowLeft } from 'lucide-react';
interface SurvivalLobbyProps {
  onStart: () => void;
  onBack: () => void;
}
export function SurvivalLobby({ onStart, onBack }: SurvivalLobbyProps) {
  return (
    <motion.div
      className="min-h-screen w-full bg-cyber-bg flex flex-col relative overflow-hidden"
      initial={{
        opacity: 0
      }}
      animate={{
        opacity: 1
      }}
      exit={{
        opacity: 0
      }}>

      {/* Background Grid */}
      <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-5 mix-blend-overlay pointer-events-none" />
      <div className="absolute inset-0 bg-[linear-gradient(to_right,#80808012_1px,transparent_1px),linear-gradient(to_bottom,#80808012_1px,transparent_1px)] bg-[size:24px_24px] pointer-events-none" />

      {/* Header */}
      <header className="p-6 relative z-10">
        <button
          onClick={onBack}
          className="text-gray-400 hover:text-white transition-colors flex items-center">

          <ArrowLeft className="w-5 h-5 mr-2" /> Voltar
        </button>
      </header>

      <main className="flex-1 flex flex-col items-center justify-center p-6 relative z-10 text-center">
        {/* Avatar / Aura Display */}
        <div className="relative mb-12">
          <div className="absolute inset-0 bg-cyber-cyan blur-[60px] opacity-20 animate-pulse-slow" />
          <div className="w-40 h-40 rounded-full border-4 border-cyber-cyan/30 relative flex items-center justify-center bg-cyber-dark shadow-[0_0_30px_rgba(0,240,255,0.2)]">
            <div className="absolute inset-0 rounded-full border border-cyber-cyan/50 animate-[spin_10s_linear_infinite]" />
            <div className="w-32 h-32 rounded-full bg-gradient-to-b from-gray-800 to-black flex items-center justify-center overflow-hidden">
              {/* Placeholder Avatar */}
              <span className="font-orbitron text-4xl font-bold text-white">
                YOU
              </span>
            </div>
            <div className="absolute -bottom-4 bg-cyber-dark border border-cyber-cyan px-4 py-1 rounded-full text-cyber-cyan font-bold text-sm shadow-neon-cyan">
              AURA NÍVEL 5
            </div>
          </div>
        </div>

        <h1 className="font-orbitron text-3xl md:text-4xl font-bold text-white mb-2">
          Modo Sobrevivência
        </h1>
        <p className="text-gray-400 mb-8 max-w-xs mx-auto">
          Chegue o mais longe possível para evoluir sua Aura. 3 erros e você
          está fora.
        </p>

        {/* Lives Status */}
        <div className="flex items-center justify-center space-x-4 mb-12 bg-cyber-input/50 p-4 rounded-xl border border-white/5 backdrop-blur-sm">
          <div className="flex space-x-2">
            {[1, 2, 3].map((i) =>
            <Shield
              key={i}
              className="w-8 h-8 text-cyber-pink fill-cyber-pink/20 drop-shadow-[0_0_8px_rgba(236,72,153,0.6)]" />

            )}
          </div>
          <span className="text-sm font-mono text-gray-400 border-l border-gray-700 pl-4">
            SISTEMA VITAL
          </span>
        </div>

        {/* Start Button */}
        <button
          onClick={onStart}
          className="w-full max-w-xs bg-gradient-to-r from-cyber-cyan to-cyber-purple hover:from-cyan-400 hover:to-purple-500 text-white font-bold py-4 px-8 rounded-lg shadow-[0_0_20px_rgba(0,240,255,0.4)] hover:shadow-[0_0_30px_rgba(0,240,255,0.6)] transition-all transform hover:scale-105 active:scale-95 flex items-center justify-center group">

          <span className="tracking-widest mr-2">INICIAR SISTEMA</span>
          <Play className="w-5 h-5 fill-current group-hover:translate-x-1 transition-transform" />
        </button>
      </main>
    </motion.div>);

}