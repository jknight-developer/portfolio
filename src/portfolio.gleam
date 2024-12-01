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
  html.div([attribute.id("mainbody"), attribute.style([#("width", "full"), #("height", "100%"), #("margin", "0 auto"), #("min-height", "100%")]),], [
    ui.stack([attribute.id("container")], [
      styles.theme(model.theme),
      styles.elements(),
      ui.centre([], html.div([attribute.id("textarea"), attribute.style([#("display", "flex")]),], [
        ui.prose([], [
          html.p([classes.text_4xl(), classes.font_alt()], [ui.centre([], 
            element.text("Site under development!"),
          )])
        ]),
      ])),
    ])
  ])
}
