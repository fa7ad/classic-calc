import React from 'react';

import './Num.css';

export default function Num({ children, onTap, className }) {
  return (
    <button className={`number ${className || ''}`} onClick={() => onTap(children)}>
      {children}
    </button>
  );
}
