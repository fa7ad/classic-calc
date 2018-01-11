import m from 'mathjs'
import React, {Component} from 'react'

import './App.css'
import Display from './Display'
import Num from './Num'
import Action from './Action'

nums = [
  "zero", "one",
  "two", "three",
  "four", "five",
  "six", "seven",
  "eight", "nine"
]

class App extends Component
  constructor: (p, c) ->
    super(p, c)
    @state =
      curr: []
      prev: []

  render: ->
    <div className="App calc">
      <Display memory={@state.prev.join ''}>{@state.curr.join ''}</Display>
      <Action className="clr" onTap={@reset}> C </Action>
      {(<Num className={n} key={n} onTap={@pushNum}>{i}</Num> for n,i in nums)}
      <Num className="dot" onTap={@pushNum}>.</Num>
      <Action className="div" val='/' onTap={@op}> &divide; </Action>
      <Action className="mul" val='*' onTap={@op}> &times; </Action>
      <Action className="min" val='-' onTap={@op}> &minus; </Action>
      <Action className="add" val='+' onTap={@op}> + </Action>
      <Action className="eql" onTap={@eql}> = </Action>
    </div>

  componentDidMount: -> window.addEventListener 'keydown', (e) =>
    if /\=|Enter|Return/.test e.key
      do @eql
    else if /[0-9]/.test e.key
      @pushNum e.key
    else if e.key is '.'
      @pushNum '.'
    else if /\+|-|\*|\//.test e.key
      @op e.key
    else if e.key is 'Delete'
      do @reset
    else if e.key is 'Backspace'
      @setState (p) -> curr: p.curr[...-1]


  pushNum: (num) =>
    if num is '.' and '.' in @state.curr.join('')
      return
    if @state.curr.length > 9
      return
    @setState (p) -> curr: p.curr.concat num

  op: (v) => @setState (p) ->
    [pprev, curr] = [p.prev, p.curr]
    if curr.length < 1
      curr = if v is '+' or v is '-' then [0] else [1]
    if pprev.length > 0
      res = m.eval pprev.concat(curr).join ''
      prev = [res, v]
    else
      prev = [curr.join(''), v]
    {prev, curr: []}

  eql: => @setState (p) ->
    [prev, curr] = [p.prev.join(''), p.curr.join('')]
    c = if not curr then prev[...-1] else m.eval "#{prev}#{curr}"
    {curr: [m.format(c, 9)], prev:[]}

  reset: =>
    @setState curr: [], prev: []


export default App