import React from 'react';
import { motion } from 'framer-motion';
import {
  Trophy,
  Users,
  Zap,
  Home,
  BarChart2,
  User,
  Play,
  ExternalLink,
  Lock,
  ChevronRight } from
'lucide-react';
interface HomeScreenProps {
  onNavigate: (screen: 'survival-lobby') => void;
}
export function HomeScreen({ onNavigate }: HomeScreenProps) {
  return (
    <motion.div
      className="min-h-screen w-full bg-cyber-bg text-white pb-20 relative overflow-x-hidden"
      initial={{
        opacity: 0
      }}
      animate={{
        opacity: 1
      }}
      exit={{
        opacity: 0
      }}>

      {/* Header */}
      <header className="p-6 flex justify-between items-center bg-cyber-dark/80 backdrop-blur-md border-b border-white/5 sticky top-0 z-20">
        <div>
          <h1 className="font-orbitron text-xl font-bold text-white">
            Olá, <span className="text-cyber-cyan">CyberAgent</span>
          </h1>
          <p className="text-xs text-gray-400 flex items-center mt-1">
            <Zap className="w-3 h-3 text-cyber-purple mr-1" /> Nível 5
          </p>
        </div>
        <div className="w-10 h-10 rounded-full bg-gradient-to-br from-cyber-cyan to-cyber-purple p-0.5">
          <div className="w-full h-full rounded-full bg-cyber-bg flex items-center justify-center">
            <User className="w-5 h-5 text-white" />
          </div>
        </div>
      </header>

      <main className="p-4 space-y-6 max-w-md mx-auto relative z-10">
        {/* Mode Carreira Card */}
        <motion.div
          whileHover={{
            scale: 1.02
          }}
          whileTap={{
            scale: 0.98
          }}
          onClick={() => onNavigate('survival-lobby')}
          className="relative group cursor-pointer">

          <div className="absolute inset-0 bg-gradient-to-r from-cyber-cyan to-cyber-purple rounded-2xl blur opacity-20 group-hover:opacity-40 transition-opacity" />
          <div className="relative bg-cyber-input/80 backdrop-blur-md border border-cyber-cyan/30 rounded-2xl p-6 overflow-hidden">
            <div className="absolute top-0 right-0 p-4 opacity-10">
              <Trophy className="w-32 h-32 text-cyber-cyan" />
            </div>
            <div className="relative z-10">
              <span className="inline-block px-2 py-1 rounded bg-cyber-cyan/20 text-cyber-cyan text-xs font-bold mb-2 border border-cyber-cyan/30">
                MODO CARREIRA
              </span>
              <h2 className="font-orbitron text-2xl font-bold text-white mb-2 group-hover:text-cyber-cyan transition-colors">
                Sobrevivência
              </h2>
              <p className="text-gray-400 text-sm mb-4 max-w-[80%]">
                Tente acertar o máximo que conseguir e evolua sua Aura.
              </p>
              <div className="flex items-center text-cyber-cyan text-sm font-bold">
                JOGAR AGORA <Play className="w-4 h-4 ml-2 fill-current" />
              </div>
            </div>
          </div>
        </motion.div>

        {/* Multiplayer Card */}
        <div className="relative opacity-60">
          <div className="absolute inset-0 bg-gradient-to-r from-cyber-purple to-cyber-pink rounded-2xl blur opacity-10" />
          <div className="relative bg-cyber-input/80 backdrop-blur-md border border-cyber-purple/20 rounded-2xl p-6 overflow-hidden">
            <div className="absolute top-0 right-0 p-4 opacity-10">
              <Users className="w-32 h-32 text-cyber-purple" />
            </div>
            <div className="relative z-10">
              <div className="flex items-center space-x-2 mb-2">
                <span className="inline-block px-2 py-1 rounded bg-cyber-purple/20 text-cyber-purple text-xs font-bold border border-cyber-purple/30">
                  COMUNIDADE
                </span>
                <span className="inline-block px-2 py-1 rounded bg-gray-800 text-gray-400 text-xs font-bold border border-gray-700 flex items-center">
                  <Lock className="w-3 h-3 mr-1" /> EM BREVE
                </span>
              </div>
              <h2 className="font-orbitron text-2xl font-bold text-gray-400 mb-2">
                Multijogador
              </h2>
              <p className="text-gray-500 text-sm mb-4 max-w-[80%]">
                Crie e jogue desafios de outros usuários.
              </p>
            </div>
          </div>
        </div>

        {/* Quick Access - Mais Cybersecurity */}
        <motion.a
          href="https://linktr.ee/cyberchristian"
          target="_blank"
          rel="noopener noreferrer"
          whileHover={{
            y: -2
          }}
          className="w-full bg-cyber-dark border border-gray-800 rounded-xl p-4 flex items-center justify-between group hover:border-cyber-pink/50 transition-colors block">

          <div className="flex items-center">
            <div className="w-10 h-10 rounded-lg bg-cyber-pink/10 flex items-center justify-center mr-4 group-hover:bg-cyber-pink/20 transition-colors">
              <Zap className="w-5 h-5 text-cyber-pink" />
            </div>
            <div className="text-left">
              <h3 className="font-bold text-white group-hover:text-cyber-pink transition-colors">
                Mais Cybersecurity
              </h3>
              <p className="text-xs text-gray-500">
                Acesse mais conteúdos do criador
              </p>
            </div>
          </div>
          <ExternalLink className="w-5 h-5 text-gray-600 group-hover:text-cyber-pink transition-colors" />
        </motion.a>
      </main>

      {/* Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 w-full bg-cyber-bg/90 backdrop-blur-lg border-t border-white/5 px-6 py-4 flex justify-between items-center z-50">
        <NavItem icon={Home} label="Home" active />
        <NavItem icon={BarChart2} label="Ranking" />
        <NavItem icon={User} label="Perfil" />
      </nav>
    </motion.div>);

}
function NavItem({
  icon: Icon,
  label,
  active




}: {icon: any;label: string;active?: boolean;}) {
  return (
    <button
      className={`flex flex-col items-center space-y-1 ${active ? 'text-cyber-cyan' : 'text-gray-500 hover:text-gray-300'}`}>

      <Icon
        className={`w-6 h-6 ${active ? 'drop-shadow-[0_0_5px_rgba(0,240,255,0.5)]' : ''}`} />

      <span className="text-[10px] font-medium tracking-wide">{label}</span>
    </button>);

}