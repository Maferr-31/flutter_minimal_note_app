part of 'note.dart';


extension GetNoteCollection on Isar {
  IsarCollection<Note> get notes => this.collection();
}

const NoteSchema = CollectionSchema(
  name: r'Note', 
  id: 6284318083599466921, 
  properties: {
    r'text': PropertySchema(
      id: 0, 
      name: r'text', 
      type: IsarType.string,
    )
  },
  estimateSize: _noteEstimateSize, 
  serialize: _noteSerialize, 
  deserialize: _noteDeserialize, 
  deserializeProp: _noteDeserializeProp, 
  idName: r'id', 
  indexes: {}, 
  links: {}, 
  embeddedSchemas: {}, 
  getId: _noteGetId, 
  getLinks: _noteGetLinks, 
  attach: _noteAttach, 
  version: '3.1.0+1',
  );

  