class App < Hyperloop::Component
  state items: []

  def render
    DIV do
      FORM do
        Item(name: "Item 1")
        Item(name: "Item 2")
      end
    end
  end
end

class Item < Hyperloop::Component
  param :name
  state cost: 0
  state amount: 0

  def render
    DIV do
      LABEL { "cost" }
      INPUT(value: state.cost, type: "tel").on(:change) do |e| 
        mutate.cost e.target.value.to_i
      end
    
      LABEL { "amount" }
      INPUT(value: state.amount, type: "tel").on(:change) do |e| 
        mutate.amount e.target.value.to_i
      end

      Result(value: calculate)
    end
  end

  def calculate
    return "nothing is free" if state.cost == 0
    return "you can't buy 0 things" if state.amount == 0
    "#{1.0 * state.cost / state.amount} per unit"
  end
end

class Result < Hyperloop::Component
  param :value

  def render
    P { params.value }
  end
end
