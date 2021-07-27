use Mix.Config

config :opencov, Opencov.Endpoint,
  http: [port: 4000],
  url: [scheme: "http", host: "demo.opencov.com", port: 80],
  secret_key_base: "my-super-secret-key-base-with-64-characters-so-that-i-dont-get-an-error"

config :opencov, Opencov.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "postgres://postgres:112233@postgres/opencov_prod",
  pool_size: 20

config :opencov, :email,
  sender: "OpenCov <info@example.com>",
  smtp: [
    relay: "smtp.example.com",
    username: "info@example.com",
    password: "my-ultra-secret-password",
    port: 587,
    ssl: false,
    tls: :always,
    auth: :always
  ]

config :phoenix, :json_library, Poison

config :opencov, :openid_connect_providers,
  keycloak: [
    discovery_document_uri: "https://access.thon.org/auth/realms/THON/.well-known/openid-configuration",
    client_id: "opencov",
    client_secret: "f4449cc0-f5a3-4005-936d-2f4a80b20cf4",
    redirect_uri: "http://ngearhart.myqnapcloud.com:8000/login/callback",
    response_type: "code",
    scope: "openid email profile"
  ]

config :opencov,
  admin_roles: [
    "ec.Executive",
    "ec.Technology",
    "tech.LeadSystemsAdministrator"
  ],
  permitted_roles: [
    "ec.Executive",
    "tech.all"
  ]

config :phoenix_live_reload,
  dirs: [
    "lib/opencov",
  ],
  backend: :fs_poll,
  backend_opts: [
    interval: 500
  ]
