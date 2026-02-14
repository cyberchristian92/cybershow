import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
  Eye,
  EyeOff,
  Check,
  AlertCircle,
  Mail,
  Lock,
  User,
  ArrowRight } from
'lucide-react';
interface AuthScreenProps {
  onSuccess: () => void;
}
type AuthMode = 'login' | 'register';
export function AuthScreen({ onSuccess }: AuthScreenProps) {
  const [mode, setMode] = useState<AuthMode>('login');
  const [isLoading, setIsLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  // Form State
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    confirmPassword: ''
  });
  const [errors, setErrors] = useState<Record<string, string>>({});
  const validate = () => {
    const newErrors: Record<string, string> = {};
    if (!formData.email.includes('@')) newErrors.email = 'Email inválido';
    if (formData.password.length < 6) newErrors.password = 'Mínimo 6 caracteres';
    if (mode === 'register') {
      if (!formData.name) newErrors.name = 'Nome é obrigatório';
      if (formData.password !== formData.confirmPassword)
      newErrors.confirmPassword = 'As senhas não coincidem';
    }
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!validate()) return;
    setIsLoading(true);
    // Simulate API call
    setTimeout(() => {
      setIsLoading(false);
      onSuccess();
    }, 1500);
  };
  const toggleMode = () => {
    setMode(mode === 'login' ? 'register' : 'login');
    setErrors({});
    setFormData({
      name: '',
      email: '',
      password: '',
      confirmPassword: ''
    });
  };
  return (
    <motion.div
      className="min-h-screen w-full bg-cyber-bg flex flex-col items-center justify-center p-4 relative overflow-hidden"
      initial={{
        opacity: 0
      }}
      animate={{
        opacity: 1
      }}
      exit={{
        opacity: 0
      }}>

      {/* Background Elements */}
      <div className="absolute top-0 left-0 w-full h-full overflow-hidden pointer-events-none">
        <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-cyber-purple/20 rounded-full blur-[100px]" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-cyber-cyan/20 rounded-full blur-[100px]" />
      </div>

      <div className="w-full max-w-md relative z-10">
        <div className="text-center mb-8">
          <img
            src="/unnamed.jpg"
            alt="Logo"
            className="w-16 h-16 mx-auto mb-4 object-contain drop-shadow-[0_0_10px_rgba(0,240,255,0.5)]" />

          <h2 className="font-orbitron text-2xl md:text-3xl font-bold text-white mb-2">
            {mode === 'login' ? 'Bem-vindo de volta' : 'Crie sua conta'}
          </h2>
          <p className="text-gray-400 text-sm">
            {mode === 'login' ?
            'Acesse sua conta para continuar' :
            'Junte-se à revolução da cibersegurança'}
          </p>
        </div>

        <div className="bg-cyber-input/50 backdrop-blur-md border border-white/10 rounded-2xl p-6 md:p-8 shadow-2xl relative overflow-hidden">
          {/* Top border gradient */}
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-cyber-cyan via-cyber-purple to-cyber-pink" />

          <form onSubmit={handleSubmit} className="space-y-5">
            <AnimatePresence mode="wait">
              {mode === 'register' &&
              <motion.div
                initial={{
                  height: 0,
                  opacity: 0
                }}
                animate={{
                  height: 'auto',
                  opacity: 1
                }}
                exit={{
                  height: 0,
                  opacity: 0
                }}
                className="overflow-hidden">

                  <div className="relative group mb-5">
                    <label className="block text-xs font-medium text-gray-400 mb-1 ml-1">
                      NOME COMPLETO
                    </label>
                    <div className="relative">
                      <User className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500 group-focus-within:text-cyber-cyan transition-colors" />
                      <input
                      type="text"
                      value={formData.name}
                      onChange={(e) =>
                      setFormData({
                        ...formData,
                        name: e.target.value
                      })
                      }
                      className="w-full bg-cyber-dark border border-gray-700 rounded-lg py-3 pl-10 pr-4 text-white placeholder-gray-600 focus:outline-none focus:border-cyber-cyan focus:ring-1 focus:ring-cyber-cyan transition-all"
                      placeholder="Seu nome" />

                    </div>
                    {errors.name &&
                  <p className="text-cyber-pink text-xs mt-1 ml-1 flex items-center">
                        <AlertCircle className="w-3 h-3 mr-1" /> {errors.name}
                      </p>
                  }
                  </div>
                </motion.div>
              }
            </AnimatePresence>

            <div className="relative group">
              <label className="block text-xs font-medium text-gray-400 mb-1 ml-1">
                EMAIL
              </label>
              <div className="relative">
                <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500 group-focus-within:text-cyber-cyan transition-colors" />
                <input
                  type="email"
                  value={formData.email}
                  onChange={(e) =>
                  setFormData({
                    ...formData,
                    email: e.target.value
                  })
                  }
                  className="w-full bg-cyber-dark border border-gray-700 rounded-lg py-3 pl-10 pr-4 text-white placeholder-gray-600 focus:outline-none focus:border-cyber-cyan focus:ring-1 focus:ring-cyber-cyan transition-all"
                  placeholder="seu@email.com" />

                {formData.email.includes('@') && !errors.email &&
                <Check className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-green-500" />
                }
              </div>
              {errors.email &&
              <p className="text-cyber-pink text-xs mt-1 ml-1 flex items-center">
                  <AlertCircle className="w-3 h-3 mr-1" /> {errors.email}
                </p>
              }
            </div>

            <div className="relative group">
              <label className="block text-xs font-medium text-gray-400 mb-1 ml-1">
                SENHA
              </label>
              <div className="relative">
                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500 group-focus-within:text-cyber-cyan transition-colors" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={formData.password}
                  onChange={(e) =>
                  setFormData({
                    ...formData,
                    password: e.target.value
                  })
                  }
                  className="w-full bg-cyber-dark border border-gray-700 rounded-lg py-3 pl-10 pr-10 text-white placeholder-gray-600 focus:outline-none focus:border-cyber-cyan focus:ring-1 focus:ring-cyber-cyan transition-all"
                  placeholder="••••••••" />

                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-white transition-colors">

                  {showPassword ?
                  <EyeOff className="w-4 h-4" /> :

                  <Eye className="w-4 h-4" />
                  }
                </button>
              </div>
              {errors.password &&
              <p className="text-cyber-pink text-xs mt-1 ml-1 flex items-center">
                  <AlertCircle className="w-3 h-3 mr-1" /> {errors.password}
                </p>
              }
            </div>

            <AnimatePresence mode="wait">
              {mode === 'register' &&
              <motion.div
                initial={{
                  height: 0,
                  opacity: 0
                }}
                animate={{
                  height: 'auto',
                  opacity: 1
                }}
                exit={{
                  height: 0,
                  opacity: 0
                }}
                className="overflow-hidden">

                  <div className="relative group mt-5">
                    <label className="block text-xs font-medium text-gray-400 mb-1 ml-1">
                      CONFIRMAR SENHA
                    </label>
                    <div className="relative">
                      <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500 group-focus-within:text-cyber-cyan transition-colors" />
                      <input
                      type="password"
                      value={formData.confirmPassword}
                      onChange={(e) =>
                      setFormData({
                        ...formData,
                        confirmPassword: e.target.value
                      })
                      }
                      className="w-full bg-cyber-dark border border-gray-700 rounded-lg py-3 pl-10 pr-4 text-white placeholder-gray-600 focus:outline-none focus:border-cyber-cyan focus:ring-1 focus:ring-cyber-cyan transition-all"
                      placeholder="••••••••" />

                    </div>
                    {errors.confirmPassword &&
                  <p className="text-cyber-pink text-xs mt-1 ml-1 flex items-center">
                        <AlertCircle className="w-3 h-3 mr-1" />{' '}
                        {errors.confirmPassword}
                      </p>
                  }
                  </div>
                </motion.div>
              }
            </AnimatePresence>

            <button
              type="submit"
              disabled={isLoading}
              className="w-full bg-gradient-to-r from-cyber-cyan to-cyber-purple hover:from-cyan-400 hover:to-purple-500 text-white font-bold py-3 px-4 rounded-lg shadow-[0_0_15px_rgba(0,240,255,0.3)] hover:shadow-[0_0_25px_rgba(0,240,255,0.5)] transition-all transform hover:scale-[1.02] active:scale-[0.98] flex items-center justify-center disabled:opacity-70 disabled:cursor-not-allowed">

              {isLoading ?
              <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" /> :

              <>
                  {mode === 'login' ? 'ENTRAR' : 'CADASTRAR'}
                  <ArrowRight className="w-5 h-5 ml-2" />
                </>
              }
            </button>
          </form>

          {mode === 'login' &&
          <div className="mt-4 text-center">
              <a
              href="#"
              className="text-sm text-cyber-cyan hover:text-white hover:underline transition-colors">

                Esqueci minha senha
              </a>
            </div>
          }

          <div className="my-6 flex items-center">
            <div className="flex-1 h-px bg-gray-700"></div>
            <span className="px-4 text-xs text-gray-500 uppercase tracking-wider">
              ou entre com
            </span>
            <div className="flex-1 h-px bg-gray-700"></div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <button className="flex items-center justify-center py-2.5 px-4 border border-gray-700 rounded-lg hover:border-cyber-cyan hover:bg-cyber-cyan/5 transition-all group">
              <svg
                className="w-5 h-5 mr-2 group-hover:drop-shadow-[0_0_5px_rgba(255,255,255,0.5)]"
                viewBox="0 0 24 24"
                fill="currentColor">

                <path
                  d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                  fill="#4285F4" />

                <path
                  d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                  fill="#34A853" />

                <path
                  d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                  fill="#FBBC05" />

                <path
                  d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                  fill="#EA4335" />

              </svg>
              <span className="text-gray-300 text-sm font-medium">Google</span>
            </button>
            <button className="flex items-center justify-center py-2.5 px-4 border border-gray-700 rounded-lg hover:border-cyber-purple hover:bg-cyber-purple/5 transition-all group">
              <svg
                className="w-5 h-5 mr-2 group-hover:drop-shadow-[0_0_5px_rgba(255,255,255,0.5)]"
                viewBox="0 0 23 23"
                fill="currentColor">

                <path fill="#f3f3f3" d="M0 0h23v23H0z" />
                <path fill="#f35325" d="M1 1h10v10H1z" />
                <path fill="#81bc06" d="M12 1h10v10H12z" />
                <path fill="#05a6f0" d="M1 12h10v10H1z" />
                <path fill="#ffba08" d="M12 12h10v10H12z" />
              </svg>
              <span className="text-gray-300 text-sm font-medium">
                Microsoft
              </span>
            </button>
          </div>
        </div>

        <div className="mt-6 text-center">
          <p className="text-gray-400 text-sm">
            {mode === 'login' ? 'Primeiro Acesso?' : 'Já tem uma conta?'}
            <button
              onClick={toggleMode}
              className="ml-2 text-cyber-cyan font-bold hover:text-white hover:underline transition-colors focus:outline-none">

              {mode === 'login' ? 'Cadastre-se' : 'Entrar'}
            </button>
          </p>
        </div>
      </div>
    </motion.div>);

}