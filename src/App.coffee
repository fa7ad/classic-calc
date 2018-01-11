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
      <Action className="div" onTap={@div}> &divide; </Action>
      <Action className="mul" onTap={@mult}> &times; </Action>
      <Action className="min" onTap={@minus}> &minus; </Action>
      <Action className="add" onTap={@add}> + </Action>
      <Action className="eql" onTap={@eql}> = </Action>
    </div>

  pushNum: (num) =>
    if num is '.' and '.' in @state.curr
      return
    if @state.curr.length > 9
      return
    @setState (p) -> curr: p.curr.concat num

  add: =>
    @setState (p) ->
      pprev = p.prev
      curr = p.curr
      if curr.length < 1
        curr = [0]
      if pprev.length > 0
        res = m.eval(pprev.concat(curr).join '')
        prev = [res, '+']
      else
        prev = [curr.join(''), '+']
      {prev, curr: []}

  minus: =>
    @setState (p) ->
      pprev = p.prev
      curr = p.curr
      if curr.length < 1
        curr = [0]
      if pprev.length > 0
        res = m.eval(pprev.concat(curr).join '')
        prev = [res, '-']
      else
        prev = [curr.join(''), '-']
      {prev, curr: []}

  mult: =>
    @setState (p) ->
      pprev = p.prev
      curr = p.curr
      if curr.length < 1
        curr = [1]
      if pprev.length > 0
        res = m.eval(pprev.concat(curr).join '')
        prev = [res, '*']
      else
        prev = [curr.join(''), '*']
      {prev, curr: []}

  div: =>
    @setState (p) ->
      pprev = p.prev
      curr = p.curr
      if curr.length < 1
        curr = [1]
      if pprev.length > 0
        res = m.eval(pprev.concat(curr).join '')
        prev = [res, '/']
      else
        prev = [curr.join(''), '/']
      {prev, curr: []}

  eql: =>
    @setState (p) ->
      c = ''
      {prev, curr} = p
      [prev, curr] = [prev.join(''), curr.join('')]
      if curr is ''
        c = prev.slice 0, -1
      else
        c = m.eval prev + curr
      {curr: [c], prev:[]}

  reset: =>
    @setState curr: [], prev: []


export default App