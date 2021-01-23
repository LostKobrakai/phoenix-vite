defmodule ViteWeb.LayoutView do
  use ViteWeb, :view

  defmacrop env do
    quote do
      unquote(Mix.env())
    end
  end
end
