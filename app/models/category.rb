class Category < ApplicationRecord
  NAMES = [
    "3D",
    "Ajax",
    "Algorithm",
    "Amp",
    "Android",
    "Angular",
    "Ansible",
    "API",
    "Arduino",
    "ASP.NET",
    "Atom",
    "Awesome Lists",
    "Amazon Web Services",
    "Azure",
    "Babel",
    "Bash",
    "Bitcoin",
    "Bootstrap",
    "Bot",
    "C",
    "Chrome",
    "Chrome extension",
    "Command line interface",
    "Clojure",
    "Code quality",
    "Code review",
    "Compiler",
    "Continuous integration",
    "COVID-19",
    "C++",
    "Cryptocurrency",
    "Crystal",
    "C#",
    "CSS",
    "Data structures",
    "Data visualization",
    "Database",
    "Deep learning",
    "Dependency management",
    "Deployment",
    "Django",
    "Docker",
    "Documentation",
    ".NET",
    "Electron",
    "Elixir",
    "Emacs",
    "Ember",
    "Emoji",
    "Emulator",
    "ESLint",
    "Ethereum",
    "Express",
    "Firebase",
    "Firefox",
    "Flask",
    "Font",
    "Framework",
    "Front end",
    "Game engine",
    "Git",
    "GitHub API",
    "Go",
    "Google",
    "Gradle",
    "GraphQL",
    "Gulp",
    "Hacktoberfest",
    "Haskell",
    "Homebrew",
    "Homebridge",
    "HTML",
    "HTTP",
    "Icon font",
    "iOS",
    "IPFS",
    "Java",
    "JavaScript",
    "Jekyll",
    "jQuery",
    "JSON",
    "The Julia Language",
    "Jupyter Notebook",
    "Koa",
    "Kotlin",
    "Kubernetes",
    "Laravel",
    "LaTeX",
    "Library",
    "Linux",
    "Localization (l10n)",
    "Lua",
    "Machine learning",
    "macOS",
    "Markdown",
    "Mastodon",
    "Material Design",
    "MATLAB",
    "Maven",
    "Minecraft",
    "Mobile",
    "Monero",
    "MongoDB",
    "Mongoose",
    "Monitoring",
    "MvvmCross",
    "MySQL",
    "NativeScript",
    "Nim",
    "Natural language processing",
    "Node.js",
    "NoSQL",
    "npm",
    "Objective-C",
    "OpenGL",
    "Operating system",
    "P2P",
    "Package manager",
    "Parsing",
    "Perl",
    "Phaser",
    "PHP",
    "PICO-8",
    "Pixel Art",
    "PostgreSQL",
    "Project management",
    "Publishing",
    "PWA",
    "Python",
    "Qt",
    "R",
    "Rails",
    "Raspberry Pi",
    "Ratchet",
    "React",
    "React Native",
    "ReactiveUI",
    "Redux",
    "REST API",
    "Ruby",
    "Rust",
    "Sass",
    "Scala",
    "scikit-learn",
    "Software-defined networking",
    "Security",
    "Server",
    "Serverless",
    "Shell",
    "Sketch",
    "SpaceVim",
    "Spring Boot",
    "SQL",
    "Storybook",
    "Support",
    "Swift",
    "Symfony",
    "Telegram",
    "Tensorflow",
    "Terminal",
    "Terraform",
    "Testing",
    "Twitter",
    "TypeScript",
    "Ubuntu",
    "Unity",
    "Unreal Engine",
    "Vagrant",
    "Vim",
    "Virtual reality",
    "Vue.js",
    "Wagtail",
    "Web Components",
    "Web app",
    "Webpack",
    "Windows",
    "WordPlate",
    "WordPress",
    "Xamarin",
    "XML"
  ]

  validates :name, presence: true
end
