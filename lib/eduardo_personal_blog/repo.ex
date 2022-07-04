defmodule EduardoPersonalBlog.Repo do
  use Ecto.Repo,
    otp_app: :eduardo_personal_blog,
    adapter: Ecto.Adapters.Postgres
end
