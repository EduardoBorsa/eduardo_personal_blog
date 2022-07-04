export $(xargs < .env)
#mix phx.digest.clean --all
#mix deps.get --only prod
#mix compile
#mix assets.deploy
#mix ecto.migrate

#elixir --erl "-detached" -S mix phx.server

mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix assets.deploy
mix phx.gen.release
current_release=$(ls ./_build/prod/rel/eduardo_personal_blog/releases | sort -nr | head -n 1)
now_in_unix_seconds=$(date +'%s')
MIX_ENV=prod mix release --path ./_build/prod/rel/eduardo_personal_blog/releases/${now_in_unix_seconds}

echo "Stoping the application ${current_release}"
# _build/prod/rel/eduardo_personal_blog/releases/${current_release}/bin/eduardo_personal_blog stop
sleep 1

echo "Running Migrations for ${now_in_unix_seconds}"
_build/prod/rel/eduardo_personal_blog/releases/${now_in_unix_seconds}/bin/eduardo_personal_blog eval "EduardoPersonalBlog.Release.migrate"
sleep 1

echo "Starting application for ${now_in_unix_seconds}"
_build/prod/rel/eduardo_personal_blog/releases/${now_in_unix_seconds}/bin/eduardo_personal_blog daemon
