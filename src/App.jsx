import { evaluate, format } from 'mathjs';
import React, { Component } from 'react';

import './App.css';
import Display from './Display';
import Num from './Num';
import Action from './Action';

const nums = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];

class App extends Component {
  constructor(p) {
    super(p);
    this.pushNum = this.pushNum.bind(this);
    this.op = this.op.bind(this);
    this.eql = this.eql.bind(this);
    this.reset = this.reset.bind(this);
    this.state = {
      curr: [],
      prev: [],
    };
  }

  render() {
    return (
      <div className='App calc'>
        <Display memory={this.state.prev.join('')}>{this.state.curr.join('')}</Display>
        <Action className='clr' onTap={this.reset}>
          {' C '}
        </Action>
        {Array.from(nums).map((n, i) => (
          <Num className={n} key={n} onTap={this.pushNum}>
            {i}
          </Num>
        ))}
        <Num className='dot' onTap={this.pushNum}>
          .
        </Num>
        <Action className='div' val='/' onTap={this.op}>
          {' '}
          &divide;{' '}
        </Action>
        <Action className='mul' val='*' onTap={this.op}>
          {` \xD7 `}
        </Action>
        <Action className='min' val='-' onTap={this.op}>
          {' - '}
        </Action>
        <Action className='add' val='+' onTap={this.op}>
          {' + '}
        </Action>
        <Action className='eql' onTap={this.eql}>
          {' = '}
        </Action>
      </div>
    );
  }

  handleKeyboardInput = (e) => {
    e.preventDefault();
    if (/\=|Enter|Return/.test(e.key)) {
      return this.eql();
    } else if (/^[0-9]/.test(e.key)) {
      return this.pushNum(e.key);
    } else if (e.key === '.') {
      return this.pushNum('.');
    } else if (/\+|-|\*|\//.test(e.key)) {
      return this.op(e.key);
    } else if (e.key === 'Delete') {
      return this.reset();
    } else if (e.key === 'Backspace') {
      return this.setState((p) => ({
        curr: p.curr.slice(0, -1),
      }));
    }
  };

  componentDidMount() {
    window.addEventListener('keydown', this.handleKeyboardInput);
  }
  componentWillUnmount() {
    window.removeEventListener('keydown', this.handleKeyboardInput);
  }

  pushNum(num) {
    this.setState(function (p) {
      let needle;
      let { curr } = p;
      if (num === '.' && ((needle = '.'), Array.from(this.state.curr.join('')).includes(needle))) {
        return;
      }
      if (this.state.curr.length === 1 && this.state.curr[0] === 0) {
        if (num !== 0) {
          curr = [];
        } else {
          return;
        }
      }
      if (this.state.curr.length > 9) {
        return;
      }
      return { curr: curr.concat(num) };
    });
  }

  op(v) {
    this.setState(function (p) {
      let prev;
      let [pprev, curr] = [p.prev, p.curr];
      if (curr.length < 1) {
        curr = v === '+' || v === '-' ? [0] : [1];
      }
      if (pprev.length > 0) {
        const res = evaluate(pprev.concat(curr).join(''));
        prev = [res, v];
      } else {
        prev = [curr.join(''), v];
      }
      return { prev, curr: [] };
    });
  }

  eql() {
    this.setState(function (p) {
      const [prev, curr] = [p.prev.join(''), p.curr.join('')];
      let c = !curr ? prev.slice(0, -1) : evaluate(`${prev}${curr}`);
      c = !prev && !curr ? 0 : c;
      return { curr: [format(c, 9)], prev: [] };
    });
  }

  reset() {
    this.setState({ curr: [], prev: [] });
  }
}

export default App;
