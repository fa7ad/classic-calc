import React from 'react';

import './Display.css';

export default function Display({ children, memory }) {
  return (
    <div className='display'>
      <div className='memory'>{('' + memory).replace(/\"/g, '')}</div>
      <input type='text' className='screen' disabled value={('' + children).replace(/\"/g, '')} />
    </div>
  );
}
