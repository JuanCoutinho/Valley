# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Default is set to 5 threads for both.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout ENV.fetch("WORKER_TIMEOUT") { 30 } if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests.
# The port is dynamically assigned by Railway or defaults to 3000.
port ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Configures the number of workers for clustered mode in production.
# Defaults to the number of physical processors if not specified.
if ENV.fetch("RAILS_ENV", "development") == "production"
  workers ENV.fetch("WEB_CONCURRENCY") { 2 } # Adjust this value based on your app's needs
end

# Logs to help debug worker lifecycle
on_worker_boot do
  puts "Worker booted: PID #{Process.pid}"
end

on_worker_shutdown do
  puts "Worker shutting down: PID #{Process.pid}"
end

# Ensure `server.pid` is removed before starting Puma
on_restart do
  puts "Cleaning up tmp/pids/server.pid"
  File.delete("tmp/pids/server.pid") if File.exist?("tmp/pids/server.pid")
end

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
