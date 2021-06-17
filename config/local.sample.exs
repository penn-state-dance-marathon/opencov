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

# SAML
config :samly, Samly.Provider,
  idp_id_from: :path_segment,
  service_providers: [
    %{
      id: "opencov",
      certfile: "sp.cert",
      keyfile: "sp.key",
      contact_name: "Technology Director",
      contact_email: "technology@thon.org",
      org_name: "Penn State THON",
      org_url: "https://thon.org"
    }
  ],
  identity_providers: [
    %{
      id: "keycloak",
      sp_id: "opencov",
      # base_url: "https://do-good.org/sso",
      metadata_file: "keycloak.xml",
      #pre_session_create_pipeline: MySamlyPipeline,
      #use_redirect_for_req: false,
      sign_requests: true,
      sign_metadata: false,
      signed_assertion_in_resp: true,
      signed_envelopes_in_resp: true,
      allow_idp_initiated_flow: true,
      #allowed_target_urls: ["https://do-good.org"],
      #nameid_format: :transient
    }
  ]