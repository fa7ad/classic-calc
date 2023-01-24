import React from 'react';

import './Action.css';

const Action = ({ className, onTap, children, val, style }) => {
  function onClick(e) {
    e.preventDefault();
    onTap(val || e);
  }
  return (
    <button className={`action ${className || ''}`} onClick={onClick} style={style}>
      {children}
    </button>
  );
};

export default Action;
