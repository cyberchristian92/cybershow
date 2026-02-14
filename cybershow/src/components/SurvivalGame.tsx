import React, { useCallback, useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
  Shield,
  Cpu,
  FastForward,
  AlertTriangle,
  CheckCircle,
  XCircle,
  ArrowRight,
  Clock,
  Timer } from
'lucide-react';
interface SurvivalGameProps {
  onGameOver: (score: number) => void;
}
const questions = [
{
  id: 1,
  question: "O que significa 'Phishing' no contexto de segurança?",
  options: [
  'Pescaria digital de dados sensíveis',
  'Um tipo de vírus que ataca hardware',
  'Software de proteção contra malware',
  'Protocolo de rede seguro e criptografado'],

  correct: 0,
  explanations: [
  'CORRETO — Phishing é uma técnica de engenharia social que "pesca" dados confidenciais das vítimas através de e-mails, sites e mensagens falsas que imitam fontes confiáveis.',
  'INCORRETO — Phishing não é um vírus de hardware. Vírus de hardware são extremamente raros e não se relacionam com engenharia social.',
  'INCORRETO — Phishing é um ataque, não um software de proteção. Ferramentas anti-phishing existem, mas o termo em si descreve a ameaça.',
  'INCORRETO — Phishing não é um protocolo de rede. Protocolos seguros como HTTPS protegem contra interceptação, mas não contra phishing diretamente.']

},
{
  id: 2,
  question: 'Qual é a melhor prática para criar uma senha forte?',
  options: [
  'Usar sua data de nascimento',
  'Sequência numérica como 123456',
  'Misturar letras, números e símbolos com 12+ caracteres',
  'Usar o nome do seu animal de estimação'],

  correct: 2,
  explanations: [
  'INCORRETO — Datas de nascimento são informações públicas facilmente descobertas em redes sociais, tornando a senha extremamente vulnerável.',
  'INCORRETO — Sequências numéricas como 123456 são as primeiras combinações testadas em ataques de força bruta. É a senha mais comum do mundo.',
  'CORRETO — Senhas fortes combinam letras maiúsculas/minúsculas, números e caracteres especiais (@#$%), com pelo menos 12 caracteres. Quanto mais longa e aleatória, mais segura.',
  'INCORRETO — Nomes de pets são facilmente descobertos em redes sociais. Atacantes usam informações pessoais públicas para adivinhar senhas.']

},
{
  id: 3,
  question: 'O que é Autenticação de Dois Fatores (2FA)?',
  options: [
  'Ter duas senhas iguais em sites diferentes',
  'Uma camada extra de verificação além da senha',
  'Login automático em dois sites simultaneamente',
  'Usar dois computadores ao mesmo tempo para acessar'],

  correct: 1,
  explanations: [
  'INCORRETO — Reutilizar senhas é uma prática perigosa. Se um site for comprometido, todos os outros ficam vulneráveis.',
  'CORRETO — 2FA adiciona uma segunda camada de verificação (código SMS, app autenticador, biometria) além da senha. Mesmo que a senha seja roubada, o invasor precisa do segundo fator.',
  'INCORRETO — Login simultâneo não tem relação com 2FA. A autenticação de dois fatores é sobre verificar sua identidade com dois métodos diferentes.',
  'INCORRETO — Usar dois computadores não aumenta a segurança da autenticação. 2FA refere-se a dois métodos de verificação, não dois dispositivos.']

},
{
  id: 4,
  question: 'O que é Ransomware?',
  options: [
  'Um antivírus gratuito',
  'Um tipo de firewall avançado',
  'Malware que sequestra dados e exige resgate',
  'Uma ferramenta de backup na nuvem'],

  correct: 2,
  explanations: [
  'INCORRETO — Ransomware é o oposto de proteção. É um dos tipos mais destrutivos de malware existentes.',
  'INCORRETO — Firewalls são ferramentas de proteção. Ransomware é uma ameaça que firewalls tentam bloquear.',
  'CORRETO — Ransomware criptografa os arquivos da vítima e exige pagamento (geralmente em criptomoedas) para devolver o acesso. Ataques famosos incluem WannaCry e NotPetya.',
  'INCORRETO — Ferramentas de backup são justamente a melhor defesa contra ransomware, mas não são a mesma coisa.']

},
{
  id: 5,
  question: 'Qual o risco de usar Wi-Fi público sem proteção?',
  options: [
  'A bateria do celular acaba mais rápido',
  'O celular pode superaquecer',
  'Seus dados podem ser interceptados por atacantes',
  'A velocidade da internet fica mais lenta'],

  correct: 2,
  explanations: [
  'INCORRETO — O consumo de bateria não é um risco de segurança relevante em redes Wi-Fi públicas.',
  'INCORRETO — Superaquecimento não está relacionado à segurança de redes Wi-Fi.',
  'CORRETO — Em redes Wi-Fi públicas, atacantes podem usar técnicas como Man-in-the-Middle (MitM) para interceptar dados não criptografados, incluindo senhas e informações bancárias. Use sempre VPN em redes públicas.',
  'INCORRETO — Embora a velocidade possa ser afetada, o risco real é a interceptação de dados sensíveis por terceiros mal-intencionados.']

},
{
  id: 6,
  question: 'O que é Engenharia Social?',
  options: [
  'Construção de redes sociais',
  'Manipulação psicológica para obter informações',
  'Engenharia de software para redes',
  'Design de interfaces de usuário'],

  correct: 1,
  explanations: [
  'INCORRETO — Engenharia Social não tem relação com a construção de plataformas de redes sociais.',
  'CORRETO — Engenharia Social é a arte de manipular pessoas para que revelem informações confidenciais. Inclui técnicas como pretexting, baiting, tailgating e phishing. O fator humano é frequentemente o elo mais fraco da segurança.',
  'INCORRETO — Engenharia de software é uma disciplina de desenvolvimento, não uma técnica de ataque.',
  'INCORRETO — Design de interfaces (UI/UX) é uma área de desenvolvimento, sem relação com ataques de segurança.']

}];

const TIMER_SECONDS = 15;
export function SurvivalGame({ onGameOver }: SurvivalGameProps) {
  const [currentQuestionIdx, setCurrentQuestionIdx] = useState(0);
  const [lives, setLives] = useState(3);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);
  const [showExplanation, setShowExplanation] = useState(false);
  const [score, setScore] = useState(0);
  const [lifelines, setLifelines] = useState({
    hack: true,
    skip: true
  });
  const [hiddenOptions, setHiddenOptions] = useState<number[]>([]);
  const [timeLeft, setTimeLeft] = useState(TIMER_SECONDS);
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);
  const currentQ = questions[currentQuestionIdx];
  // Timer countdown
  useEffect(() => {
    if (isAnswered || showExplanation) return;
    if (timeLeft <= 0) {
      // Time's up — treat as wrong answer
      handleTimeUp();
      return;
    }
    const interval = setInterval(() => {
      setTimeLeft((prev) => prev - 1);
    }, 1000);
    return () => clearInterval(interval);
  }, [timeLeft, isAnswered, showExplanation]);
  const handleTimeUp = useCallback(() => {
    if (isAnswered) return;
    setSelectedOption(null);
    setIsAnswered(true);
    setIsCorrect(false);
    setTimeout(() => {
      setShowExplanation(true);
      setLives((prev) => prev - 1);
    }, 500);
  }, [isAnswered]);
  const handleAnswer = (index: number) => {
    if (isAnswered) return;
    setSelectedOption(index);
    setIsAnswered(true);
    const correct = index === currentQ.correct;
    setIsCorrect(correct);
    setTimeout(() => {
      setShowExplanation(true);
      if (correct) {
        setScore((prev) => prev + 1);
      } else {
        setLives((prev) => prev - 1);
      }
    }, 1000);
  };
  const handleNext = () => {
    setShowExplanation(false);
    setIsAnswered(false);
    setSelectedOption(null);
    setHiddenOptions([]);
    setIsCorrect(null);
    setTimeLeft(TIMER_SECONDS);
    if (
    lives <= 0 ||
    lives === 1 && isCorrect === false && selectedOption !== null)
    {

      // Check if lives just hit 0
    } // If lives are 0 after this answer
    if (lives <= 0) {
      onGameOver(score);
      return;
    }
    if (currentQuestionIdx < questions.length - 1) {
      setCurrentQuestionIdx((prev) => prev + 1);
    } else {
      onGameOver(score);
    }
  };
  const useHack = () => {
    if (!lifelines.hack || isAnswered) return;
    const wrongOptions = currentQ.options.
    map((_, idx) => idx).
    filter((idx) => idx !== currentQ.correct);
    const shuffled = wrongOptions.sort(() => Math.random() - 0.5);
    const toHide = shuffled.slice(0, 2);
    setHiddenOptions(toHide);
    setLifelines((prev) => ({
      ...prev,
      hack: false
    }));
  };
  const useSkip = () => {
    if (!lifelines.skip || isAnswered) return;
    setLifelines((prev) => ({
      ...prev,
      skip: false
    }));
    setTimeLeft(TIMER_SECONDS);
    setHiddenOptions([]);
    if (currentQuestionIdx < questions.length - 1) {
      setCurrentQuestionIdx((prev) => prev + 1);
    } else {
      onGameOver(score);
    }
  };
  const timerPercentage = timeLeft / TIMER_SECONDS * 100;
  const timerColor =
  timeLeft <= 5 ?
  'text-red-500' :
  timeLeft <= 10 ?
  'text-yellow-400' :
  'text-cyber-cyan';
  const timerBarColor =
  timeLeft <= 5 ?
  'bg-red-500' :
  timeLeft <= 10 ?
  'bg-yellow-400' :
  'bg-cyber-cyan';
  // Full-screen explanation
  if (showExplanation) {
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

        {/* Top accent */}
        <div
          className={`w-full h-1 ${isCorrect ? 'bg-green-500' : 'bg-red-500'}`} />


        <div className="flex-1 flex flex-col p-6 max-w-2xl mx-auto w-full overflow-y-auto">
          {/* Status Header */}
          <div className="flex items-center mb-8 mt-4">
            {isCorrect ?
            <div className="bg-green-500/20 p-3 rounded-full mr-4 shrink-0">
                <CheckCircle className="w-8 h-8 text-green-500" />
              </div> :

            <div className="bg-red-500/20 p-3 rounded-full mr-4 shrink-0">
                {selectedOption === null ?
              <Clock className="w-8 h-8 text-red-500" /> :

              <AlertTriangle className="w-8 h-8 text-red-500" />
              }
              </div>
            }
            <div>
              <h2
                className={`font-orbitron text-2xl font-bold ${isCorrect ? 'text-green-500' : 'text-red-500'}`}>

                {isCorrect ?
                'SISTEMA SEGURO' :
                selectedOption === null ?
                'TEMPO ESGOTADO' :
                'FALHA DE SEGURANÇA'}
              </h2>
              <p className="text-gray-400 text-sm mt-1">
                Rodada {currentQuestionIdx + 1} • Aura {score}
              </p>
            </div>
          </div>

          {/* Question Recap */}
          <div className="bg-cyber-input/50 border border-white/10 rounded-xl p-5 mb-6">
            <p className="text-xs text-gray-500 uppercase tracking-wider mb-2">
              Pergunta
            </p>
            <p className="text-white font-medium text-lg leading-relaxed">
              {currentQ.question}
            </p>
          </div>

          {/* All Options with Explanations */}
          <div className="space-y-4 mb-8">
            {currentQ.options.map((option, idx) => {
              const isCorrectOption = idx === currentQ.correct;
              const wasSelected = idx === selectedOption;
              let borderColor = 'border-gray-800';
              let bgColor = 'bg-cyber-dark/50';
              let labelColor = 'text-gray-500';
              if (isCorrectOption) {
                borderColor = 'border-green-500/50';
                bgColor = 'bg-green-500/5';
                labelColor = 'text-green-500';
              } else if (wasSelected && !isCorrectOption) {
                borderColor = 'border-red-500/50';
                bgColor = 'bg-red-500/5';
                labelColor = 'text-red-500';
              }
              return (
                <motion.div
                  key={idx}
                  initial={{
                    opacity: 0,
                    x: -20
                  }}
                  animate={{
                    opacity: 1,
                    x: 0
                  }}
                  transition={{
                    delay: idx * 0.1
                  }}
                  className={`border ${borderColor} ${bgColor} rounded-xl p-4`}>

                  <div className="flex items-start">
                    <div
                      className={`shrink-0 w-8 h-8 rounded-full border-2 flex items-center justify-center mr-3 mt-0.5 ${isCorrectOption ? 'border-green-500 bg-green-500/20' : wasSelected ? 'border-red-500 bg-red-500/20' : 'border-gray-700 bg-gray-800'}`}>

                      {isCorrectOption ?
                      <CheckCircle className="w-4 h-4 text-green-500" /> :
                      wasSelected ?
                      <XCircle className="w-4 h-4 text-red-500" /> :

                      <span className="text-xs text-gray-500 font-bold">
                          {String.fromCharCode(65 + idx)}
                        </span>
                      }
                    </div>
                    <div className="flex-1">
                      <p
                        className={`font-medium mb-1 ${isCorrectOption ? 'text-green-400' : wasSelected ? 'text-red-400' : 'text-gray-400'}`}>

                        {option}
                      </p>
                      <p className={`text-sm leading-relaxed ${labelColor}`}>
                        {currentQ.explanations[idx]}
                      </p>
                    </div>
                  </div>
                </motion.div>);

            })}
          </div>

          {/* Continue Button */}
          <div className="mt-auto pb-6">
            <button
              onClick={handleNext}
              className="w-full bg-gradient-to-r from-cyber-cyan to-cyber-purple hover:from-cyan-400 hover:to-purple-500 text-white font-bold py-4 px-4 rounded-lg shadow-[0_0_15px_rgba(0,240,255,0.3)] hover:shadow-[0_0_25px_rgba(0,240,255,0.5)] transition-all flex items-center justify-center">

              {lives <= 0 ? 'VER RESULTADO' : 'PRÓXIMA PERGUNTA'}
              <ArrowRight className="w-5 h-5 ml-2" />
            </button>
          </div>
        </div>
      </motion.div>);

  }
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

      {/* Timer Bar */}
      <div className="w-full h-1 bg-gray-900">
        <motion.div
          className={`h-full ${timerBarColor} transition-colors duration-500`}
          initial={{
            width: '100%'
          }}
          animate={{
            width: `${timerPercentage}%`
          }}
          transition={{
            duration: 0.3
          }} />

      </div>

      {/* Top Bar */}
      <header className="p-4 flex justify-between items-center bg-cyber-dark/50 backdrop-blur-md border-b border-white/5 z-20">
        <div className="flex items-center space-x-3">
          <div className="bg-cyber-purple/20 border border-cyber-purple text-cyber-purple px-3 py-1 rounded-full text-xs font-bold font-orbitron">
            AURA {score}
          </div>
          <span className="text-gray-500 text-xs">
            Rodada {currentQuestionIdx + 1}/{questions.length}
          </span>
        </div>
        <div className="flex items-center space-x-3">
          {/* Timer */}
          <div
            className={`flex items-center space-x-1 font-mono font-bold text-lg ${timerColor} transition-colors`}>

            <Timer className="w-4 h-4" />
            <span>{timeLeft}s</span>
          </div>
          {/* Lives */}
          <div className="flex space-x-1 ml-2">
            {[1, 2, 3].map((i) =>
            <Shield
              key={i}
              className={`w-5 h-5 transition-all duration-300 ${i <= lives ? 'text-cyber-pink fill-cyber-pink/20' : 'text-gray-800'}`} />

            )}
          </div>
        </div>
      </header>

      {/* Main Game Area */}
      <main className="flex-1 flex flex-col justify-center p-6 relative z-10 max-w-2xl mx-auto w-full">
        {/* Question Card */}
        <div className="mb-8 text-center">
          <h2 className="font-orbitron text-xl md:text-2xl font-bold text-white leading-relaxed">
            {currentQ.question}
          </h2>
        </div>

        {/* Options */}
        <div className="grid grid-cols-1 gap-3 mb-8">
          {currentQ.options.map((option, idx) => {
            if (hiddenOptions.includes(idx)) {
              return (
                <div
                  key={idx}
                  className="w-full p-4 rounded-xl border-2 border-gray-900 bg-gray-900/30 opacity-30">

                  <span className="line-through text-gray-700">{option}</span>
                </div>);

            }
            let stateStyles =
            'bg-cyber-input border-gray-700 text-gray-300 hover:border-cyber-cyan hover:bg-cyber-cyan/5';
            if (isAnswered) {
              if (idx === currentQ.correct) {
                stateStyles =
                'bg-green-500/20 border-green-500 text-green-400 shadow-[0_0_15px_rgba(34,197,94,0.3)]';
              } else if (idx === selectedOption) {
                stateStyles = 'bg-red-500/20 border-red-500 text-red-400';
              } else {
                stateStyles = 'opacity-40 border-gray-800';
              }
            }
            return (
              <motion.button
                key={idx}
                initial={{
                  opacity: 0,
                  y: 20
                }}
                animate={{
                  opacity: 1,
                  y: 0
                }}
                transition={{
                  delay: idx * 0.08
                }}
                onClick={() => handleAnswer(idx)}
                disabled={isAnswered}
                className={`w-full p-4 rounded-xl border-2 text-left font-medium transition-all duration-300 ${stateStyles}`}>

                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <span className="w-8 h-8 rounded-full border border-current/30 flex items-center justify-center text-sm font-bold mr-3 shrink-0 opacity-60">
                      {String.fromCharCode(65 + idx)}
                    </span>
                    <span className="flex-1">{option}</span>
                  </div>
                  {isAnswered && idx === currentQ.correct &&
                  <CheckCircle className="w-5 h-5 shrink-0 ml-2" />
                  }
                  {isAnswered &&
                  idx === selectedOption &&
                  idx !== currentQ.correct &&
                  <XCircle className="w-5 h-5 shrink-0 ml-2" />
                  }
                </div>
              </motion.button>);

          })}
        </div>

        {/* Lifelines */}
        <div className="flex justify-center space-x-6">
          <button
            onClick={useHack}
            disabled={!lifelines.hack || isAnswered}
            className={`flex flex-col items-center p-3 rounded-lg border transition-all ${lifelines.hack && !isAnswered ? 'border-cyber-cyan bg-cyber-cyan/10 hover:bg-cyber-cyan/20 text-cyber-cyan' : 'border-gray-800 bg-gray-900/50 text-gray-600 opacity-50 cursor-not-allowed'}`}>

            <Cpu className="w-6 h-6 mb-1" />
            <span className="text-[10px] font-bold">HACKEAR</span>
            <span className="text-[9px] mt-0.5 opacity-70">
              Tirar duas alternativas
            </span>
          </button>
          <button
            onClick={useSkip}
            disabled={!lifelines.skip || isAnswered}
            className={`flex flex-col items-center p-3 rounded-lg border transition-all ${lifelines.skip && !isAnswered ? 'border-cyber-purple bg-cyber-purple/10 hover:bg-cyber-purple/20 text-cyber-purple' : 'border-gray-800 bg-gray-900/50 text-gray-600 opacity-50 cursor-not-allowed'}`}>

            <FastForward className="w-6 h-6 mb-1" />
            <span className="text-[10px] font-bold">PULAR</span>
            <span className="text-[9px] mt-0.5 opacity-70">Pular pergunta</span>
          </button>
        </div>
      </main>
    </motion.div>);

}