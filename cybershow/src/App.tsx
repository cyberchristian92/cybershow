import React, { useState } from 'react';
import { AnimatePresence } from 'framer-motion';
import { SplashScreen } from './components/SplashScreen';
import { AuthScreen } from './components/AuthScreen';
import { OnboardingScreen } from './components/OnboardingScreen';
import { HomeScreen } from './components/HomeScreen';
import { SurvivalLobby } from './components/SurvivalLobby';
import { SurvivalGame } from './components/SurvivalGame';
import { SurvivalResult } from './components/SurvivalResult';
type AppState =
'splash' |
'auth' |
'onboarding' |
'home' |
'survival-lobby' |
'survival-game' |
'survival-result';
export function App() {
  const [currentState, setCurrentState] = useState<AppState>('splash');
  const [lastScore, setLastScore] = useState(0);
  const handleSplashComplete = () => setCurrentState('auth');
  const handleAuthSuccess = () => setCurrentState('onboarding');
  const handleOnboardingComplete = () => setCurrentState('home');
  // Navigation Handlers
  const goHome = () => setCurrentState('home');
  const goToLobby = () => setCurrentState('survival-lobby');
  const startGame = () => setCurrentState('survival-game');
  const handleGameOver = (score: number) => {
    setLastScore(score);
    setCurrentState('survival-result');
  };
  return (
    <div className="min-h-screen w-full bg-cyber-bg text-white font-sans overflow-hidden">
      <AnimatePresence mode="wait">
        {currentState === 'splash' &&
        <SplashScreen key="splash" onComplete={handleSplashComplete} />
        }

        {currentState === 'auth' &&
        <AuthScreen key="auth" onSuccess={handleAuthSuccess} />
        }

        {currentState === 'onboarding' &&
        <OnboardingScreen
          key="onboarding"
          onComplete={handleOnboardingComplete} />

        }

        {currentState === 'home' &&
        <HomeScreen
          key="home"
          onNavigate={(screen) => setCurrentState(screen)} />

        }

        {currentState === 'survival-lobby' &&
        <SurvivalLobby key="lobby" onStart={startGame} onBack={goHome} />
        }

        {currentState === 'survival-game' &&
        <SurvivalGame key="game" onGameOver={handleGameOver} />
        }

        {currentState === 'survival-result' &&
        <SurvivalResult
          key="result"
          score={lastScore}
          onRestart={startGame}
          onHome={goHome} />

        }
      </AnimatePresence>
    </div>);

}