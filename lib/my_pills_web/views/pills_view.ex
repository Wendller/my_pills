defmodule MyPillsWeb.PillsView do
  use MyPillsWeb, :view

  alias MyPills.Pills.Pill

  def render("create.json", %{pill: %Pill{} = pill}) do
    %{
      pill: pill
    }
  end

  def render("pill.json", %{pill: %Pill{} = pill}) do
    %{
      pill: pill
    }
  end

  def render("pills.json", %{pills: pills}) do
    %{
      pills: pills
    }
  end
end
