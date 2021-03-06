import React from 'react';
import SortableComponent from "./PlanningTab";


function ShowResult(props){
    const notes = props.notes;
    const listNotes = Object.keys(notes).map((note, index, tab)=>
        <li key={index}>Equipe {note} = {notes[note]}</li>
    );
    return(
        <ul>{listNotes}</ul>
    )
}

export default ShowResult;