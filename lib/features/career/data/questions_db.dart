import 'package:cybershow/features/career/domain/models/question_model.dart';

/// Banco de Questões do CyberShow
/// Adicione novas questões copiando e colando a estrutura abaixo.
final List<Question> questionsDatabase = [
  const Question(
    id: '1',
    text: "O que significa 'Phishing' no contexto de segurança?",
    options: [
      'Pescaria digital de dados sensíveis',
      'Um tipo de vírus que ataca hardware',
      'Software de proteção contra malware',
      'Protocolo de rede seguro e criptografado'
    ],
    correctOptionIndex: 0,
    points: 1,
    explanations: [
      'CORRETO — Phishing é uma técnica de engenharia social que "pesca" dados confidenciais das vítimas através de e-mails, sites e mensagens falsas que imitam fontes confiáveis.',
      'INCORRETO — Phishing não é um vírus de hardware. Vírus de hardware são extremamente raros e não se relacionam com engenharia social.',
      'INCORRETO — Phishing é um ataque, não um software de proteção. Ferramentas anti-phishing existem, mas o termo em si descreve a ameaça.',
      'INCORRETO — Phishing não é um protocolo de rede. Protocolos seguros como HTTPS protegem contra interceptação, mas não contra phishing diretamente.'
    ],
  ),
  const Question(
    id: '2',
    text: 'Qual é a melhor prática para criar uma senha forte?',
    options: [
      'Usar sua data de nascimento',
      'Sequência numérica como 123456',
      'Misturar letras, números e símbolos com 12+ caracteres',
      'Usar o nome do seu animal de estimação'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Datas de nascimento são informações públicas facilmente descobertas em redes sociais, tornando a senha extremamente vulnerável.',
      'INCORRETO — Sequências numéricas como 123456 são as primeiras combinações testadas em ataques de força bruta. É a senha mais comum do mundo.',
      'CORRETO — Senhas fortes combinam letras maiúsculas/minúsculas, números e caracteres especiais (@#\$%), com pelo menos 12 caracteres. Quanto mais longa e aleatória, mais segura.',
      'INCORRETO — Nomes de pets são facilmente descobertos em redes sociais. Atacantes usam informações pessoais públicas para adivinhar senhas.'
    ],
  ),
  const Question(
    id: '3',
    text: 'O que é Autenticação de Dois Fatores (2FA)?',
    options: [
      'Ter duas senhas iguais em sites diferentes',
      'Uma camada extra de verificação além da senha',
      'Login automático em dois sites simultaneamente',
      'Usar dois computadores ao mesmo tempo para acessar'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Reutilizar senhas é uma prática perigosa. Se um site for comprometido, todos os outros ficam vulneráveis.',
      'CORRETO — 2FA adiciona uma segunda camada de verificação (código SMS, app autenticador, biometria) além da senha. Mesmo que a senha seja roubada, o invasor precisa do segundo fator.',
      'INCORRETO — Login simultâneo não tem relação com 2FA. A autenticação de dois fatores é sobre verificar sua identidade com dois métodos diferentes.',
      'INCORRETO — Usar dois computadores não aumenta a segurança da autenticação. 2FA refere-se a dois métodos de verificação, não dois dispositivos.'
    ],
  ),
  const Question(
    id: '4',
    text: 'O que é Ransomware?',
    options: [
      'Um antivírus gratuito',
      'Um tipo de firewall avançado',
      'Malware que sequestra dados e exige resgate',
      'Uma ferramenta de backup na nuvem'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Ransomware é o oposto de proteção. É um dos tipos mais destrutivos de malware existentes.',
      'INCORRETO — Firewalls são ferramentas de proteção. Ransomware é uma ameaça que firewalls tentam bloquear.',
      'CORRETO — Ransomware criptografa os arquivos da vítima e exige pagamento (geralmente em criptomoedas) para devolver o acesso. Ataques famosos incluem WannaCry e NotPetya.',
      'INCORRETO — Ferramentas de backup são justamente a melhor defesa contra ransomware, mas não são a mesma coisa.'
    ],
  ),
  const Question(
    id: '5',
    text: 'Qual o risco de usar Wi-Fi público sem proteção?',
    options: [
      'A bateria do celular acaba mais rápido',
      'O celular pode superaquecer',
      'Seus dados podem ser interceptados por atacantes',
      'A velocidade da internet fica mais lenta'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — O consumo de bateria não é um risco de segurança relevante em redes Wi-Fi públicas.',
      'INCORRETO — Superaquecimento não está relacionado à segurança de redes Wi-Fi.',
      'CORRETO — Em redes Wi-Fi públicas, atacantes podem usar técnicas como Man-in-the-Middle (MitM) para interceptar dados não criptografados, incluindo senhas e informações bancárias. Use sempre VPN em redes públicas.',
      'INCORRETO — Embora a velocidade possa ser afetada, o risco real é a interceptação de dados sensíveis por terceiros mal-intencionados.'
    ],
  ),
  const Question(
    id: '6',
    text: 'O que é Engenharia Social?',
    options: [
      'Construção de redes sociais',
      'Manipulação psicológica para obter informações',
      'Engenharia de software para redes',
      'Design de interfaces de usuário'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Engenharia Social não tem relação com a construção de plataformas de redes sociais.',
      'CORRETO — Engenharia Social é a arte de manipular pessoas para que revelem informações confidenciais. Inclui técnicas como pretexting, baiting, tailgating e phishing. O fator humano é frequentemente o elo mais fraco da segurança.',
      'INCORRETO — Engenharia de software é uma disciplina de desenvolvimento, não uma técnica de ataque.',
      'INCORRETO — Design de interfaces (UI/UX) é uma área de desenvolvimento, sem relação com ataques de segurança.'
    ],
  ),
  const Question(
    id: '7',
    text: 'Qual a função principal de uma VPN?',
    options: [
      'Aumentar a velocidade da internet',
      'Criptografar sua conexão e ocultar seu IP',
      'Proteger contra vírus de hardware',
      'Limpar arquivos temporários do sistema'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — VPNs geralmente diminuem levemente a velocidade devido à criptografia.',
      'CORRETO — VPN (Rede Privada Virtual) cria um túnel criptografado para seus dados e mascara seu endereço IP real, protegendo sua privacidade e segurança em redes públicas.',
      'INCORRETO — VPNs protegem a conexão, não o hardware contra vírus.',
      'INCORRETO — VPN é uma ferramenta de rede, não de manutenção de sistema.'
    ],
  ),
  const Question(
    id: '8',
    text: 'O que é um Firewall?',
    options: [
      'Uma parede física que protege o servidor',
      'Um antivírus para smartphones',
      'Uma barreira de segurança que monitora o tráfego de rede',
      'Um programa para apagar incêndios digitais'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Firewall é um software ou hardware de rede, não uma parede física de construção.',
      'INCORRETO — Embora proteja, não é classificado como antivírus. Antivírus escaneiam arquivos; firewalls filtram tráfego.',
      'CORRETO — Firewall é uma barreira de segurança que monitora e controla o tráfego de rede de entrada e saída com base em regras de segurança predefinidas.',
      'INCORRETO — O termo "firewall" (parede de fogo) é uma metáfora para barreira de contenção, não literal.'
    ],
  ),
  const Question(
    id: '9',
    text: 'Por que é importante manter o software atualizado?',
    options: [
      'Para gastar mais bateria',
      'Para ocupar mais espaço no disco',
      'Para corrigir falhas de segurança conhecidas',
      'Para mudar as cores dos ícones'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Atualizações buscam otimização, não gasto de bateria.',
      'INCORRETO — O uso de espaço é consequência, não o objetivo.',
      'CORRETO — Atualizações (patches) frequentemente corrigem vulnerabilidades de segurança (exploits) que hackers poderiam usar para invadir seu sistema.',
      'INCORRETO — Mudanças visuais são secundárias. A segurança é a prioridade das atualizações de sistema.'
    ],
  ),
  const Question(
    id: '10',
    text: 'O que o ícone de cadeado (HTTPS) no navegador indica?',
    options: [
      'Que o site é 100% seguro contra golpes',
      'Que a comunicação entre você e o site é criptografada',
      'Que o site não possui vírus',
      'Que o site pertence ao governo'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Sites de phishing também podem usar HTTPS. O cadeado garante a conexão, não a legitimidade do conteúdo.',
      'CORRETO — HTTPS (HyperText Transfer Protocol Secure) significa que os dados transmitidos entre seu navegador e o site são criptografados e não podem ser lidos se interceptados.',
      'INCORRETO — Um site com HTTPS ainda pode conter arquivos maliciosos para download.',
      'INCORRETO — Qualquer site pode obter um certificado SSL/TLS para ter HTTPS.'
    ],
  ),
  const Question(
    id: '11',
    text: 'O que fazer se encontrar um pen drive na rua?',
    options: [
      'Conectar no computador para ver o que tem dentro',
      'Conectar no computador do trabalho para verificar',
      'Nunca conectar em dispositivos seus',
      'Formatar imediatamente sem abrir'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Esta é uma técnica clássica de ataque. O pen drive pode conter malware que se instala automaticamente ao conectar.',
      'INCORRETO — Conectar na rede corporativa é ainda mais perigoso, colocando toda a empresa em risco.',
      'CORRETO — Dispositivos desconhecidos podem conter malwares de execução automática ou até capacitores que queimam a porta USB (USB Killers). Jamais conecte.',
      'INCORRETO — Ao conectar para formatar, o malware já pode ter sido executado.'
    ],
  ),
  const Question(
    id: '12',
    text: 'O que a "Navegação Anônima" realmente faz?',
    options: [
      'Torna você invisível para o provedor de internet',
      'Esconde seu IP de todos os sites',
      'Não salva histórico, cookies e cache localmente',
      'Protege contra todos os vírus'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Seu provedor (ISP) e o administrador da rede ainda podem ver tudo o que você acessa.',
      'INCORRETO — Os sites ainda veem seu IP. Para esconder o IP, é necessário uma VPN.',
      'CORRETO — A navegação anônima apenas impede que o navegador salve o histórico, cookies e dados de formulário no seu próprio dispositivo.',
      'INCORRETO — Ela não oferece proteção adicional contra malware ou downloads maliciosos.'
    ],
  ),
  const Question(
    id: '13',
    text: 'Qual é a regra básica de Backup 3-2-1?',
    options: [
      '3 cópias, 2 tipos de mídia, 1 local remoto',
      '3 arquivos, 2 pastas, 1 drive',
      '3 dias, 2 horas, 1 minuto',
      '3 pessoas, 2 senhas, 1 cofre'
    ],
    correctOptionIndex: 0,
    points: 1,
    explanations: [
      'CORRETO — A regra 3-2-1 recomenda: Ter 3 cópias dos dados (1 original + 2 backups), em 2 tipos de mídia diferentes (ex: HD externo e Nuvem), com 1 cópia fora do local físico (offsite).',
      'INCORRETO — Esta não é a definição da estratégia de backup robusta.',
      'INCORRETO — Termos de tempo não definem a estrutura do backup.',
      'INCORRETO — Controle de acesso é importante, mas não é a regra de backup 3-2-1.'
    ],
  ),
  const Question(
    id: '14',
    text: 'O que é Doxing?',
    options: [
      'Um tipo de documento de texto',
      'Ato de pesquisar e vazar dados privados de alguém',
      'Uma técnica de otimização de sites (SEO)',
      'Um estilo de design gráfico'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Doxing vem de "docs" (documentos), mas refere-se à ação maliciosa.',
      'CORRETO — Doxing é a prática de investigar e publicar informações privadas ou identificáveis (como endereço, telefone, CPF) de uma pessoa na internet, geralmente com intenção maliciosa.',
      'INCORRETO — SEO é para melhorar ranking em buscas, não vazar dados.',
      'INCORRETO — Não é um estilo visual.'
    ],
  ),
  const Question(
    id: '15',
    text: 'Qual a vantagem de usar um Gerenciador de Senhas?',
    options: [
      'Ele deixa a internet mais rápida',
      'Permite usar a mesma senha em tudo com segurança',
      'Cria e armazena senhas complexas e únicas para cada site',
      'Impede que você acesse sites perigosos'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Gerenciadores não afetam velocidade da conexão.',
      'INCORRETO — Usar a mesma senha em tudo é uma falha grave. O gerenciador serve justamente para EVITAR isso.',
      'CORRETO — Gerenciadores de senhas geram senhas fortes e aleatórias para cada serviço e as memorizam para você, exigindo que você decore apenas uma senha mestra.',
      'INCORRETO — Alguns avisam sobre sites inseguros, mas a função principal é gerenciamento de credenciais.'
    ],
  ),
  const Question(
    id: '16',
    text: 'O que é uma Botnet?',
    options: [
      'Uma rede social para robôs',
      'Uma rede de dispositivos infectados controlados remotamente',
      'Uma internet mais rápida via fibra ótica',
      'Um software de chat automatizado'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Não é uma rede social.',
      'CORRETO — Botnet é uma rede de computadores (ou dispositivos IoT) infectados por malware (bots) e controlados por um invasor para realizar ataques em massa, como DDoS ou envio de spam.',
      'INCORRETO — Não tem relação com tecnologia de fibra.',
      'INCORRETO — Chatbots são softwares de atendimento, Botnets são redes maliciosas.'
    ],
  ),
  const Question(
    id: '17',
    text: 'O que é um exploit "Zero Day"?',
    options: [
      'Um vírus que dura zero dias',
      'Uma falha de segurança recém-descoberta e ainda sem correção',
      'Um ataque que ocorre à meia-noite',
      'Um software de teste beta'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Não se refere à duração do vírus.',
      'CORRETO — "Zero Day" (Dia Zero) refere-se a uma vulnerabilidade que os desenvolvedores acabaram de descobrir e para a qual ainda não existe correção (patch), deixando os sistemas expostos até ser corrigida.',
      'INCORRETO — O termo não tem relação com o horário do ataque.',
      'INCORRETO — Softwares beta podem ter bugs, mas Zero Day é uma falha crítica específica explorada por hackers.'
    ],
  ),
  const Question(
    id: '18',
    text: 'Qual a diferença entre HTTP e HTTPS?',
    options: [
      'HTTPS é mais lento que HTTP',
      'HTTPS é pago, HTTP é gratuito',
      'HTTPS criptografa a comunicação, HTTP não',
      'Não há diferença real, é apenas marketing'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Modernamente, a diferença de velocidade é imperceptível, e o HTTPS pode até ser mais rápido com HTTP/2.',
      'INCORRETO — Certificados HTTPS podem ser gratuitos (ex: Let\'s Encrypt).',
      'CORRETO — O "S" vem de Secure. O HTTPS usa TLS/SSL para criptografar os dados entre o cliente e o servidor, impedindo que terceiros leiam a informação no caminho.',
      'INCORRETO — A diferença é fundamental para a segurança da web moderna.'
    ],
  ),
  const Question(
    id: '19',
    text: 'O que é "Shoulder Surfing" (Surf de Ombro)?',
    options: [
      'Um esporte aquático digital',
      'Espiar a tela de alguém para roubar senhas ou dados',
      'Navegar na internet sentado no ombro de alguém',
      'Usar Wi-Fi do vizinho sem permissão'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Não é um esporte.',
      'CORRETO — Shoulder Surfing é a técnica simples de olhar por cima do ombro de alguém (fisicamente) para ver o que ela está digitando ou acessando na tela, como senhas de banco ou PINs.',
      'INCORRETO — Interpretação literal incorreta.',
      'INCORRETO — Isso seria furto de sinal ou invasão de rede, não shoulder surfing.'
    ],
  ),
  const Question(
    id: '20',
    text: 'Para que serve um "Cookie" de navegador?',
    options: [
      'Para alimentar o mascote do navegador',
      'Para armazenar preferências e manter sessões de login',
      'Para deixar o computador mais rápido',
      'É um tipo de vírus inofensivo'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — É um termo técnico, não literal.',
      'CORRETO — Cookies são pequenos arquivos de texto salvos pelo site no seu computador para lembrar quem você é, o que está no seu carrinho de compras ou suas preferências de idioma.',
      'INCORRETO — Cookies mal gerenciados podem até deixar o navegador mais lento.',
      'INCORRETO — Cookies não são vírus, embora possam ser usados para rastreamento invasivo (tracking cookies).'
    ],
  ),
  const Question(
    id: '21',
    text: 'O que é um ataque DDoS (Negação de Serviço Distribuído)?',
    options: [
      'Deletar o sistema operacional do servidor',
      'Roubar os dados dos clientes',
      'Sobregarregar um servidor com tráfego falso para tirá-lo do ar',
      'Desligar a energia do data center'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — DDoS visa a disponibilidade, não a integridade dos dados (deletar).',
      'INCORRETO — O objetivo principal do DDoS é derrubar o serviço, não necessariamente roubar dados (embora possa servir de distração).',
      'CORRETO — Em um ataque DDoS, milhares de dispositivos (botnet) acessam um alvo simultaneamente para esgotar seus recursos, tornando-o inacessível para usuários legítimos.',
      'INCORRETO — Isso seria sabotagem física.'
    ],
  ),
  const Question(
    id: '22',
    text: 'O que significa a sigla IoT?',
    options: [
      'Internet of Technology',
      'Internal Operating Tool',
      'Internet of Things (Internet das Coisas)',
      'Input Output Transfer'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Tradução incorreta.',
      'INCORRETO — Termo inventado.',
      'CORRETO — IoT refere-se à rede de objetos físicos (geladeiras, lâmpadas, carros) que possuem sensores e software para se conectar e trocar dados pela internet.',
      'INCORRETO — Termo técnico de hardware, mas não IoT.'
    ],
  ),
  const Question(
    id: '23',
    text: 'Qual o maior risco de segurança em dispositivos IoT baratos?',
    options: [
      'Eles quebram fácil',
      'Consomem muita energia',
      'Muitos têm senhas padrão (admin/admin) e sem atualizações',
      'Eles interferem no sinal do Wi-Fi'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Durabilidade não é risco de segurança cibernética.',
      'INCORRETO — Eficiência energética não é segurança.',
      'CORRETO — Dispositivos IoT baratos frequentemente vêm com senhas padrão que nunca são trocadas e firmware que nunca recebe correção de segurança, tornando-os alvos fáceis para botnets.',
      'INCORRETO — Interferência é um problema de performance, não de segurança crítica.'
    ],
  ),
  const Question(
    id: '24',
    text: 'O que é um "Deepfake"?',
    options: [
      'Uma notícia falsa em texto',
      'Um mergulho profundo na web',
      'Mídia sintética (vídeo/áudio) criada por IA para imitar alguém',
      'Um perfil falso no Facebook'
    ],
    correctOptionIndex: 2,
    points: 1,
    explanations: [
      'INCORRETO — Fake News textual não é deepfake.',
      'INCORRETO — "Deep" refere-se a Deep Learning (IA), não profundidade literal.',
      'CORRETO — Deepfakes usam inteligência artificial para trocar rostos ou vozes em vídeos/áudios com realismo impressionante, frequentemente usados para desinformação ou golpes.',
      'INCORRETO — Perfil falso é "Catfishing" ou apenas Fake.'
    ],
  ),
  const Question(
    id: '25',
    text: 'O que é Criptografia de Ponta a Ponta (E2EE)?',
    options: [
      'Criptografar apenas o início e o fim da mensagem',
      'Apenas o remetente e o destinatário podem ler a mensagem',
      'O servidor da empresa pode ler as mensagens para moderação',
      'Uma senha que protege o aplicativo'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Criptografa TODO o trajeto.',
      'CORRETO — E2EE garante que a mensagem é cifrada no dispositivo do remetente e só é decifrada no dispositivo do destinatário. Nem mesmo a empresa dona do app (ex: WhatsApp/Signal) consegue ler o conteúdo.',
      'INCORRETO — Se o servidor pode ler, não é ponta a ponta.',
      'INCORRETO — Senha de app é controle de acesso local.'
    ],
  ),
  const Question(
    id: '26',
    text: 'O que é Bloatware?',
    options: [
      'Um vírus que incha a bateria',
      'Softwares pré-instalados indesejados que ocupam recursos',
      'Uma roupa especial para proteção contra radiação',
      'Um firewall muito pesado'
    ],
    correctOptionIndex: 1,
    points: 1,
    explanations: [
      'INCORRETO — Não existe vírus que incha bateria fisicamente (hardware falha).',
      'CORRETO — Bloatware são aplicativos que já vêm instalados em dispositivos novos (celulares/PCs) pelos fabricantes, que muitas vezes o usuário não quer, não usa e não consegue desinstalar facilmente, consumindo espaço e memória.',
      'INCORRETO — Não é vestuário.',
      'INCORRETO — Não se refere a firewall.'
    ],
  ),
];
