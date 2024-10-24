class Category < ApplicationRecord
  NAMES = {
      "3D": "3D.png",
      "Ajax": "Ajax.png",
      "Algorithm": "Algorithm.png",
      "Amp": "Amp.png",
      "Android": "Android.png",
      "Angular": "Angular.png",
      "Ansible": "Ansible.png",
      "API": "API.png",
      "Arduino": "Arduino.png",
      "ASP.NET": "ASP.NET.png",
      "Atom": "Atom.png",
      "Awesome Lists": "Awesome-Lists.jpg",
      "Azure": "Azure.png",
      "Babel": "Babel.png",
      "Bash": "Bash.png",
      "Bitcoin": "Bitcoin.png",
      "Bootstrap": "Bootstrap.png",
      "Bot": "Bot.jpg",
      "C": "C.png",
      "Chrome": "Chrome.jpg",
      "Chrome extension": "Chrome-Extension.png",
      "Command line interface": "Command-Line-Interface.png",
      "Clojure": "Clojure.png",
      "Code quality": "Code-Quality.png",
      "Code review": "Code-Review.png",
      "Compiler": "Compiler.png",
      "Composer": "Ansible.png",
      "COVID-19": "COVID-19.png",
      "C++": "c++.png",
      "C#": "Ansible.png",
      "Continuous Delivery": "C.png",
      "Cloud Security": "Babel.png",
      "Cryptocurrency": "cryptocurrency.png",
      "Crystal": "crystal.png",
      "CSS": "css.png",
      "Data structures": "data-structures.png",
      "Data visualization": "data-visualization.png",
      "Database": "database.png",
      "Deep learning": "deep-learning.jpg",
      "Dependency management": "dependency-management.png",
      "Deployment": "deployment.png",
      "Django": "django.png",
      "Docker": "docker.png",
      "Documentation": "documentation.png",
      "Decentralized Finance (DeFi)": "Ajax.png",
      "Data Governance": "API.png",
      ".NET": "dotNET.png",
      "Electron": "electron.png",
      "Elixir": "elixir.png",
      "Emacs": "emacs.png",
      "Ember": "ember.jpg",
      "Emoji": "emoji.jpg",
      "Emulator": "emulator.jpg",
      "ESLint": "ESlint.png",
      "Ethereum": "ethereum.png",
      "Express": "express.png",
      "Firebase": "firebase.png",
      "Firefox": "firefox.png",
      "Flask": "flask.png",
      "Flutter": "React-Native.png",
      "Font": "font.png",
      "Framework": "framework.png",
      "Front end": "front-end.png",
      "Game engine": "game-engine.png",
      "Git": "git.png",
      "GitHub API": "github-api.png",
      "Go": "go.png",
      "Google": "google.jpg",
      "Gradle": "gradle.png",
      "GraphQL": "graphQL.png",
      "Gulp": "gulp.png",
      "Gsap": "Amp.png",
      "Hacktoberfest": "hacktoberfest.png",
      "Haskell": "haskell.png",
      "Homebrew": "homebrew.jpg",
      "Homebridge": "homebridge.png",
      "HTML": "HTML.png",
      "HTTP": "HTTP.png",
      "Icon font": "Icon-font.jpg",
      "iOS": "iOS.png",
      "IPFS": "IPFS.png",
      "Infrastructure as Code (IaC)": "Azure.png",
      "Java": "java.png",
      "JavaScript": "javascript.png",
      "Jekyll": "jekyll.png",
      "jQuery": "jQuery.png",
      "JSON": "JSON.png",
      "Jupyter Notebook": "jupyter-notebook.png",
      "Koa": "koa.png",
      "Kotlin": "kotlin.png",
      "Kubernetes": "kubernetes.png",
      "Laravel": "laravel.png",
      "LaTeX": "LaTex.png",
      "Library": "Library.jpg",
      "Linux": "Linux.png",
      "Localization (l10n)": "Localization.png",
      "Lua": "lua.png",
      "Machine learning": "machine-learning.png",
      "macOS": "macOS.png",
      "Markdown": "markdown.png",
      "Mastodon": "mastodon.png",
      "Material Design": "material-design.png",
      "MATLAB": "MATLAB.png",
      "Maven": "maven.jpg",
      "Minecraft": "minecraft.jpg",
      "Mobile": "mobile.jpg",
      "Monero": "monero.png",
      "MongoDB": "MongoDB.png",
      "Mongoose": "Mongoose.png",
      "Monitoring": "monitoring.png",
      "MvvmCross": "MvvmCross.png",
      "MySQL": "MySQL.png",
      "NativeScript": "NativeScript.png",
      "Nim": "Nim.png",
      "Natural language processing": "Natural-Language-Processing.png",
      "Node.js": "Node.js.png",
      "NoSQL": "NoSQL.png",
      "npm": "npm.png",
      "Objective-C": "objective-c.png",
      "OpenGL": "OpenGL.jpg",
      "Operating system": "Operating-System.png",
      "P2P": "P2P.png",
      "Package manager": "Package-Manager.png",
      "Packagist": "Phaser.jpg",
      "Parsing": "Parsing.png",
      "Perl": "Perl.png",
      "Phaser": "Phaser.jpg",
      "PHP": "PHP.png",
      "PICO-8": "PICO-8.png",
      "Pixel Art": "Pixel-Art.png",
      "PostgreSQL": "PostgreSQL.jpg",
      "Project management": "Project-Management.png",
      "Publishing": "Publishing.png",
      "PWA": "PWA.png",
      "Python": "PWA.png",
      "Qt": "Qt.png",
      "R": "R.png",
      "Rails": "Rails.png",
      "Raspberry Pi": "Raspberry-Pi.png",
      "Ratchet": "Ratchet.png",
      "React": "React.png",
      "React Native": "React-Native.png",
      "ReactiveUI": "ReactiveUI.png",
      "Redux": "Redux.png",
      "REST API": "REST-API.png",
      "Ruby": "Ruby.png",
      "Rust": "Rust.jpg",
      "Sass": "Sass.png",
      "Scala": "Scala.png",
      "scikit-learn": "scitkit-learn.png",
      "Software-defined networking": "Software-Defined-Networking.png",
      "Security": "Security.png",
      "Server": "Server.png",
      "Serverless": "Serverless.png",
      "Shell": "Shell.png",
      "Sketch": "Sketch.png",
      "SpaceVim": "SpaceVim.jpg",
      "Spring Boot": "Spring-Boot.jpg",
      "SQL": "SQL.jpg",
      "Storybook": "Storybook.png",
      "Support": "Support.png",
      "Swift": "Swift.png",
      "Symfony": "Symfony.png",
      "Telegram": "Telegram.png",
      "Tensorflow": "Tensorflow.png",
      "Terminal": "Terminal.png",
      "Testing": "Testing.png",
      "Twitter": "Twitter.png",
      "TypeScript": "TypeScript.png",
      "Ubuntu": "Ubuntu.png",
      "Unity": "Unity.png",
      "Unreal Engine": "Unreal-Engine.png",
      "Vagrant": "Vagrant.jpg",
      "Vim": "Vim.png",
      "Virtual reality": "Virtual-Reality.png",
      "Vue.js": "Vue.js.png",
      "Wagtail": "Wagtail.png",
      "Web Components": "Web-Components.jpg",
      "Web app": "Web-app.png",
      "Webpack": "Webpack.png",
      "Windows": "Windows.png",
      "WordPlate": "WordPlate.jpg",
      "WordPress": "WordPress.png",
      "Xamarin": "Xamarin.png",
      "XML": "XML.png",
      "Generative AI": "ember.jpg",
      "AI": "Xamarin.png",
      "Low code": "Web-app.png",
      "IoT": "Wagtail.png",
      "Audio": "Vagrant.jpg",
      "NFT": "Ubuntu.png",
      "Next.js": "Vim.png",
      "Games": "Virtual-Reality.png",
      "Microservices": "Unity.png",
      "Blockchain": "Wagtail.png",
      "Cybersecurity": "Twitter.png",
      "Augmented Reality": "Terminal.png",
      "Cloud": "Testing.png",
      "Backend": "Wagtail.png",
      "Distributed Systems": "Vim.png",
      "Computer Science": "Scala.png",
      "Interview": "Rust.jpg",
      "Learning": "SQL.jpg",
      "Big Data": "Unity.png",
      "System": "Vim.png",
      "Architecture": "Wagtail.png",
      "Resources": "Ubuntu.png",
      "System Design": "Terminal.png",
      "Scalability": "Wagtail.png",
      "Accessibility": "Chrome-Extension.png",
      "Agile": "COVID-19.png",
      "Amazon Web Services": "C.png",
      "Analytics": "Bot.jpg",
      "Animation": "Bootstrap.png",
      "API Development": "Bitcoin.png",
      "Artificial Intelligence": "Bash.png",
      "Automation": "Babel.png",
      "Bioinformatics": "Azure.png",
      "Browser": "Awesome-Lists.jpg",
      "Caching": "Atom.png",
      "Chatbot": "Arduino.png",
      "ChatOps": "Ansible.png",
      "ChatGPT": "Angular.png",
      "CI/CD": "Android.png",
      "CLI": "Amp.png",
      "Cloud Computing": "Amazon-Web-Services.png",
      "Cloud Native": "Algorithm.png",
      "CMS": "Ajax.png",
      "Competitive Programming": "ASP.NET.png",
      "Computer Graphics": "API.png",
      "Computer Vision": "3D.png",
      "Concurrency": "Chrome-Extension.png",
      "Containerization": "COVID-19.png",
      "Continuous integration": "C.png",
      "Cryptography": "Bot.jpg",
      "Data Analysis": "Bootstrap.png",
      "Data Engineering": "Bitcoin.png",
      "Data Mining": "Bash.png",
      "Data Science": "Babel.png",
      "Data Warehousing": "Azure.png",
      "Design": "Awesome-Lists.jpg",
      "Design Patterns": "Atom.png",
      "DevOps": "Arduino.png",
      "DevRel": "Ansible.png",
      "DevSecOps": "Angular.png",
      "E-commerce": "Android.png",
      "Edge Computing": "Amp.png",
      "Embedded Systems": "Amazon-Web-Services.png",
      "Ethical AI": "Algorithm.png",
      "Ethical Hacking": "Ajax.png",
      "ETL": "ASP.NET.png",
      "Explainable AI": "API.png",
      "Fintech": "3D.png",
      "Frontend Frameworks": "Chrome-Extension.png",
      "Functional Programming": "COVID-19.png",
      "Game AI": "C.png",
      "Game Development": "Bot.jpg",
      "Geolocation": "Bootstrap.png",
      "GitOps": "Bitcoin.png",
      "GUI": "Bash.png",
      "Hardware": "Babel.png",
      "HealthTech": "Azure.png",
      "High Performance Computing": "Awesome-Lists.jpg",
      "High-Performance Computing": "Atom.png",
      "Human-Computer Interaction": "Arduino.png",
      "Image Processing": "Ansible.png",
      "Infrastructure as Code": "Angular.png",
      "Knowledge Graphs": "Android.png",
      "Liquid": "Ansible.png",
      "Low-Code": "Amp.png",
      "Magento": "Bot.jpg",
      "MLOps": "Amazon-Web-Services.png",
      "Microservices Architecture": "Algorithm.png",
      "Mobile App": "Ajax.png",
      "Mobile DevOps": "ASP.NET.png",
      "Multi-cloud Strategies": "Babel.png",
      "NestJs": "Vim.png",
      "Network Programming": "API.png",
      "Neural Networks": "3D.png",
      "Observability": "Chrome-Extension.png",
      "Open Data": "COVID-19.png",
      "Open Source": "C.png",
      "Performance": "Bot.jpg",
      "Programming": "Bootstrap.png",
      "Progressive Web Apps (PWAs)": "Babel.png",
      "Quantum Computing": "Bitcoin.png",
      "Real-time Systems": "Bash.png",
      "Robotics": "Babel.png",
      "SaaS": "Azure.png",
      "Scientific Computing": "Awesome-Lists.jpg",
      "Scripting": "Atom.png",
      "Search": "Arduino.png",
      "Semantic Web": "Ansible.png",
      "Signal Processing": "Angular.png",
      "Simulation": "Android.png",
      "Software Architecture": "Amp.png",
      "Software Engineering": "Amazon-Web-Services.png",
      "Software Testing": "Algorithm.png",
      "Streaming": "Ajax.png",
      "Systems Programming": "ASP.NET.png",
      "Serverless Computing": "Arduino.png",
      "Solidity": "Xamarin.png",
      "Spring Boot": "Awesome-Lists.jpg",
      "Smart Contracts Development": "Bot.jpg",  
      "Svelte": "Vim.png",    
      "Shopify": "Babel.png",
      "Template Engine": "API.png",
      "Terraform": "3D.png",
      "Text Editors": "Chrome-Extension.png",
      "Threat Intelligence": "Ansible.png",
      "Three.js": "Vim.png",
      "UI/UX": "COVID-19.png",
      "Version Control": "C.png",
      "Virtualization": "Bot.jpg",
      "Web Accessibility": "Bootstrap.png",
      "Web APIs": "Bitcoin.png",
      "WebAssembly": "Bash.png",
      "WebGL": "Babel.png",
      "WebRTC": "Azure.png",
      "Web Scraping": "Awesome-Lists.jpg",
      "WebSockets": "Atom.png"
  }.with_indifferent_access

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :active_products, -> { where("product_categories.active = ?", true) }, through: :product_categories, source: :product

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image_name, presence: true

  include PgSearch::Model
  pg_search_scope :search,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }
end
