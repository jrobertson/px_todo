#!/usr/bin/env ruby

# file: px_todo.rb


require 'polyrex-headings'
require 'pxrowx'


class PxTodo

  def initialize(raw_s)
    
    s, _ = RXFHelper.read(raw_s)

    # remove the file heading     
    lines = s.lines
    lines.shift 3
    
    @fields = %w( title heading when duration priority status note tags)
    declar = "<?ph schema='items[title]/todo[#{@fields.join(',')}]'" + 
        " format_masks[0]='[!title]'?>"

    # add a marker to identify the headings after parsing the records
    
    s2 = lines.join.gsub(/^#+\s+/,'\0:')
    
    @px = PolyrexHeadings.new(declar + "\n" + s2).to_polyrex
    
    @px.each_recursive do |x, parent, level|

      yield x if block_given?

      todo = x.title
      raw_status = todo.slice!(/\[.*\]\s+/)
      x.title = todo

      status  = raw_status =~ /\[\s*x\s*\]/ ? 'done' : ''      

      x.status = status
            
      # is there a note?
      
      note = todo[/^note:\s+(.*)/i,1]
      
      if note and parent.is_a? PolyrexObjects::Todo then
        
        parent.note = note
        x.delete
          
      end
      
      # is it a heading?
      
      heading = todo[/^:(.*)/,1]
      
      if heading then

        # does the heading contain tags?
        
        raw_tags = heading.slice!(/\s+#.*$/)
        x.tags = raw_tags[/#\s+(.*)/,1] if raw_tags
        x.heading = heading
        x.title = ''        
        
      end
      
    end        

  end
  

  def to_px
    @px
  end
  
  
end
