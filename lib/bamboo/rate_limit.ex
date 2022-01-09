defmodule Bamboo.RateLimiter do
  @moduledoc """
  -when rate limit is exceeded, one is unable to access any endpoint
  """
  use GenServer
    require Logger

    @tab :rate_limiter_requests
    @max_requests 5
    @time :timer.seconds(60)

    def start_link do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end

    def init(_) do
       :ets.new(@tab, [:set, :named_table, :public, write_concurrency: true, read_concurrency: true])
       {:ok, %{}}
    end

    def log(uid) do
        case :ets.update_counter(@tab, uid, {2, 1}, {uid, 0}) do
            count when count > @max_requests -> {:error, :rate_limited}
            _count -> :ok
        end
    end

    def handle_info(:sweep, state) do
        Logger.debug("Sweeping requests")
        :ets.delete_all_objects(@tab)
        schedule_sweep()

        {:noreply, state}
    end

    def schedule_sweep() do
        Process.send_after(self(), :sweep, @time)
    end

end
