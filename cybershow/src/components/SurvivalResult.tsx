import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
  Save,
  RotateCcw,
  Home,
  Trophy,
  AlertOctagon,
  Check,
  User } from
'lucide-react';
interface SurvivalResultProps {
  score: number;
  onRestart: () => void;
  onHome: () => void;
}
export function SurvivalResult({
  score,
  onRestart,
  onHome
}: SurvivalResultProps) {
  const [showNameInput, setShowNameInput] = useState(false);
  const [playerName, setPlayerName] = useState('');
  const [saved, setSaved] = useState(false);
  const isWin = score > 0;
  const handleSave = () => {
    if (!playerName.trim()) return;
    // Save to localStorage ranking
    const existing = JSON.parse(
      localStorage.getItem('cybershow-ranking') || '[]'
    );
    const entry = {
      name: playerName.trim(),
      aura: score,
      date: new Date().toLocaleDateString('pt-BR')
    };
    existing.push(entry);
    existing.sort((a: any, b: any) => b.aura - a.aura);
    localStorage.setItem('cybershow-ranking', JSON.stringify(existing));
    setSaved(true);
    // Navigate home after brief delay
    setTimeout(() => {
      onHome();
    }, 1500);
  };
  return (
    <motion.div
      className="min-h-screen w-full bg-cyber-bg flex flex-col items-center justify-center p-6 relative overflow-hidden text-center"
      initial={{
        opacity: 0
      }}
      animate={{
        opacity: 1
      }}
      exit={{
        opacity: 0
      }}>

      {/* Background */}
      <div className={`absolute inset-0 opacity-15 ${isWin ? '' : ''}`}>
        <div
          className={`absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[400px] h-[400px] rounded-full blur-[120px] ${isWin ? 'bg-cyber-cyan' : 'bg-red-600'}`} />

      </div>
      <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-5 mix-blend-overlay pointer-events-none" />

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
          type: 'spring',
          bounce: 0.4
        }}
        className="relative z-10 max-w-sm w-full">

        {/* Icon */}
        <div className="mb-6 flex justify-center">
          {isWin ?
          <motion.div
            animate={{
              boxShadow: [
              '0 0 20px rgba(0,240,255,0.3)',
              '0 0 40px rgba(0,240,255,0.6)',
              '0 0 20px rgba(0,240,255,0.3)']

            }}
            transition={{
              duration: 2,
              repeat: Infinity
            }}
            className="w-20 h-20 rounded-full bg-cyber-cyan/20 flex items-center justify-center border-2 border-cyber-cyan">

              <Trophy className="w-10 h-10 text-cyber-cyan" />
            </motion.div> :

          <div className="w-20 h-20 rounded-full bg-red-500/20 flex items-center justify-center border-2 border-red-500 shadow-[0_0_20px_rgba(239,68,68,0.4)]">
              <AlertOctagon className="w-10 h-10 text-red-500" />
            </div>
          }
        </div>

        {/* Title */}
        <h1
          className={`font-orbitron text-2xl font-bold mb-1 ${isWin ? 'text-white' : 'text-red-500 glitch-text'}`}
          data-text={isWin ? 'CHECKPOINT ALCANÇADO' : 'DESCONEXÃO'}>

          {isWin ? 'CHECKPOINT ALCANÇADO' : 'DESCONEXÃO'}
        </h1>
        <p className="text-gray-500 text-sm mb-8">
          {isWin ? 'Sua evolução foi registrada.' : 'Suas defesas falharam.'}
        </p>

        {/* Aura Display — Clean and Prominent */}
        <div className="bg-cyber-input/60 border border-white/10 rounded-2xl p-8 mb-8 backdrop-blur-sm">
          <p className="text-xs text-gray-500 uppercase tracking-[0.3em] mb-3">
            Aura Atingida
          </p>
          <div className="flex items-baseline justify-center">
            <motion.span
              initial={{
                scale: 0
              }}
              animate={{
                scale: 1
              }}
              transition={{
                type: 'spring',
                bounce: 0.5,
                delay: 0.3
              }}
              className="text-7xl font-orbitron font-black text-white"
              style={{
                textShadow: isWin ?
                '0 0 20px rgba(0,240,255,0.5)' :
                '0 0 20px rgba(239,68,68,0.3)'
              }}>

              {score}
            </motion.span>
            <span
              className={`text-lg font-orbitron font-bold ml-2 ${isWin ? 'text-cyber-cyan' : 'text-red-400'}`}>

              AURA
            </span>
          </div>
        </div>

        {/* Save Flow */}
        <AnimatePresence mode="wait">
          {saved ?
          <motion.div
            key="saved"
            initial={{
              opacity: 0,
              y: 10
            }}
            animate={{
              opacity: 1,
              y: 0
            }}
            className="flex flex-col items-center space-y-2 mb-6">

              <div className="w-12 h-12 rounded-full bg-green-500/20 flex items-center justify-center border border-green-500">
                <Check className="w-6 h-6 text-green-500" />
              </div>
              <p className="text-green-400 font-bold text-sm">
                Progresso salvo no ranking!
              </p>
              <p className="text-gray-500 text-xs">Voltando ao menu...</p>
            </motion.div> :
          showNameInput ?
          <motion.div
            key="nameInput"
            initial={{
              opacity: 0,
              y: 10
            }}
            animate={{
              opacity: 1,
              y: 0
            }}
            className="space-y-4 mb-6">

              <div className="relative">
                <User className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500" />
                <input
                type="text"
                value={playerName}
                onChange={(e) => setPlayerName(e.target.value)}
                placeholder="Seu nome para o ranking"
                maxLength={20}
                autoFocus
                className="w-full bg-cyber-dark border border-gray-700 rounded-lg py-3 pl-10 pr-4 text-white placeholder-gray-600 focus:outline-none focus:border-cyber-cyan focus:ring-1 focus:ring-cyber-cyan transition-all"
                onKeyDown={(e) => e.key === 'Enter' && handleSave()} />

              </div>
              <button
              onClick={handleSave}
              disabled={!playerName.trim()}
              className="w-full bg-gradient-to-r from-cyber-cyan to-cyber-purple hover:from-cyan-400 hover:to-purple-500 text-white font-bold py-3 px-4 rounded-lg shadow-[0_0_15px_rgba(0,240,255,0.3)] hover:shadow-[0_0_25px_rgba(0,240,255,0.5)] transition-all flex items-center justify-center disabled:opacity-40 disabled:cursor-not-allowed">

                <Save className="w-5 h-5 mr-2" /> SALVAR
              </button>
            </motion.div> :

          <motion.div
            key="actions"
            initial={{
              opacity: 0,
              y: 10
            }}
            animate={{
              opacity: 1,
              y: 0
            }}
            className="space-y-3">

              <button
              onClick={() => setShowNameInput(true)}
              className="w-full bg-gradient-to-r from-cyber-cyan to-cyber-purple hover:from-cyan-400 hover:to-purple-500 text-white font-bold py-3 px-4 rounded-lg shadow-[0_0_15px_rgba(0,240,255,0.3)] hover:shadow-[0_0_25px_rgba(0,240,255,0.5)] transition-all flex items-center justify-center">

                <Save className="w-5 h-5 mr-2" /> SALVAR PROGRESSO
              </button>

              <button
              onClick={onRestart}
              className={`w-full border font-bold py-3 px-4 rounded-lg flex items-center justify-center hover:bg-white/5 transition-colors ${isWin ? 'border-gray-700 text-gray-300' : 'bg-red-500/10 border-red-500 text-red-400 hover:bg-red-500/20'}`}>

                <RotateCcw className="w-5 h-5 mr-2" />
                {isWin ? 'JOGAR NOVAMENTE' : 'REINICIAR SISTEMA'}
              </button>

              <button
              onClick={onHome}
              className="w-full text-gray-500 hover:text-white py-2 text-sm flex items-center justify-center transition-colors">

                <Home className="w-4 h-4 mr-2" /> Voltar ao Menu
              </button>
            </motion.div>
          }
        </AnimatePresence>
      </motion.div>
    </motion.div>);

}