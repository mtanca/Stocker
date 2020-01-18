defmodule UpdateDatabase do
  use Timex

  def current? do
    Timex.today()
  end
end
