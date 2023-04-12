#!/bin/bash

# This script will create a new React app called dndkit-demo, install the necessary dependencies for React DnDKit, create the App component file, update the index.js file to render the App 
component, and start the development server. To run the script, save it to a file (e.g., dndkit.sh), make it executable (chmod +x dndkit.sh), and then run it (./dndkit.sh).

# Install Node.js and create a new React app
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
npx create-react-app dndkit-demo
cd dndkit-demo

# Install React DnDKit dependencies
npm install react @dnd-kit/core @dnd-kit/sortable @dnd-kit/utilities

# Create the App component file
cat <<EOF > src/App.js
import React, { useState } from 'react';
import { DndContext, DragOverlay } from '@dnd-kit/core';
import { useSortable } from '@dnd-kit/sortable';
import { CSS } from '@dnd-kit/utilities';

const items = ['Item 1', 'Item 2', 'Item 3'];

function SortableItem({ id, children }) {
  const { attributes, listeners, setNodeRef, transform, transition } = useSortable({
    id,
  });

  const style = {
    transform: CSS.Transform.toString(transform),
    transition,
  };

  return (
    <div ref={setNodeRef} style={style} {...attributes} {...listeners}>
      {children}
    </div>
  );
}

function App() {
  const [activeId, setActiveId] = useState(null);

  return (
    <DndContext onDragStart={event => setActiveId(event.active.id)}>
      {items.map((item, index) => (
        <SortableItem key={item} id={item}>
          {item}
        </SortableItem>
      ))}
      <DragOverlay>
        {activeId ? <div>{activeId}</div> : null}
      </DragOverlay>
    </DndContext>
  );
}

export default App;
EOF

# Update the index.js file to render the App component
sed -i 's/<App \/>/<App \/><\/React.StrictMode>/g' src/index.js

# Start the development server
npm start

