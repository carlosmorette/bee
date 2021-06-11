defmodule BeeWeb.GameLive do
  use BeeWeb, :live_view

  @colors [
    "red",
    "purple",
    "yellow",
    "brown",
    "orange"
  ]

  def mount(_params, _session, socket) do
    if connected?(socket) do
      IO.puts("Connected...")

      Process.send_after(self(), :change_color, 2000)
    end

    {:ok, assign(socket, x: 0, y: 0, color: "red")}
  end

  def render(assigns) do
    ~L"""
    <div phx-window-keydown="keydown">
      <p>X: <%= inspect(@x) %></p>
      <p>Y: <%= inspect(@y) %></p>
      <svg width="100%" height="80vh" version="1.1" xmlns="http://www.w3.org/2000/svg">
       <rect 
         x="<%= @x %>"
         y="<%= @y %>"
         width="30" 
         height="30" 
         fill="<%= @color %>" 
         stroke-width="4"
      />
      </svg>
    </div>
    """
  end

  # capture message
  def handle_info(:change_color, socket) do
    Process.send_after(self(), :change_color, 2000)
    {:noreply, assign(socket, :color, Enum.random(@colors))}
  end

  def handle_event("keydown", %{"key" => "ArrowUp"}, socket) do
    {:noreply, update(socket, :y, &(&1 - 5))}
  end

  def handle_event("keydown", %{"key" => "ArrowDown"}, socket) do
    {:noreply, update(socket, :y, &(&1 + 5))}
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, update(socket, :x, &(&1 - 5))}
  end

  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, update(socket, :x, &(&1 + 5))}
  end

  def handle_event("keydown", _key, socket) do
    {:noreply, socket}
  end
end
