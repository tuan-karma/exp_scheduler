## Note on Phoenix Directory Structure

This project will use Ecto, Config, and a public CLI interface, so it should mimic a phoenix directory structure/organization.

├── _build : `created by mix command, hold compilation artefacts`
├── assets : `front-end assets, such as js, css, images ...` Run `npm install` inside this dir
├── config : `config/config.exs is the main entry point, other env congfig such as dev.exs...`
├── deps : `hold all mix dependencies`
├── lib : `your application source code`
│   └── hello : `host all your business logic and business domain. Schema & Contexts, interface with DB`
│   └── hello.ex :
│   └── hello_web : `View and Controller in MVC`
│   └── hello_web.ex : `Contain helper macros to use at the beginning/setup of routers, controller, views, and channels.`
├── priv : `database scripts, translation files, ...`
└── test : `mirrors the same structure that found in lib`


References:

  - https://hexdocs.pm/phoenix/directory_structure.html
