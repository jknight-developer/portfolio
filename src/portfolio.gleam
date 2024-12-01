import gleam/io
import gleam/uri.{type Uri}
import lustre
import lustre/attribute.{type Attribute}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import lustre/ui.{type Theme, Theme}
import lustre/ui/classes
import lustre/ui/colour
import lustre/ui/styles
import modem

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub type Model {
  Model(route: Route, state: State, theme: Theme)
}

pub type Route {
  Index
}

pub type State {
  State
}

fn init(_flags) -> #(Model, Effect(Msg)) {
  let theme = Theme(
    primary: colour.purple(),
    greyscale: colour.grey(),
    error: colour.red(),
    warning: colour.yellow(),
    success: colour.green(),
    info: colour.blue(),
  )
  #(Model(route: Index, state: State, theme: theme), effect.none())
}

fn on_url_change(uri: Uri) -> Msg {
  case uri.path_segments(uri.path) {
    ["index"] -> OnRouteChange(Index)
    _ -> OnRouteChange(Index)
  }
}

pub type Msg {
  NoMessage
  OnRouteChange(Route)
}

pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    NoMessage -> #(model, effect.none())
    OnRouteChange(route) -> #(Model(route, model.state, model.theme), effect.none())
  }
}

pub fn view(model: Model) -> Element(Msg) {
  html.div([attribute.style([#("background", "#efe998"), #("height", "100%"), #("min-height", "100%")])], [
    styles.theme(model.theme),
    styles.elements(),
    case model {
      Model(Index, _, _) -> index(model)
    },
  ])
}

fn index(_model: Model) -> Element(Msg) {
  let flex_container = attribute.style([#("height", "100%"), #("padding", "0"), #("margin", "0"), #("display", "flex"), #("align-items", "center"), #("justify-content", "center")])
  let flex_item = attribute.style([#("padding", "2rem"), #("width", "100%"), #("margin", "4rem"), #("text-align", "center")])
  html.div([flex_container], [
    html.div([flex_item, classes.text_4xl(), classes.font_alt()], [html.p([], [element.text("Site under development")])]),
    html.div([flex_item, classes.text_2xl(), classes.font_alt()], [html.p([], [element.text("To contact me, send an email to jonathan@jknightdev.co.uk")])]),
  ])
}
