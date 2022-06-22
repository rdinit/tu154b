import os

instruments=os.listdir("Instruments-3d")
for instrument in instruments:
    try:
        files = os.listdir("Instruments-3d/"+instrument)
    except:
        continue
    xmls = list(filter(lambda x: x.endswith("xml"), files))
    for file in xmls:
        with open("Instruments-3d"+"/"+instrument+"/"+file, "r") as f:
            text = f.read()
        symb_num=text.find("<animation")
        paste_text=f'''<!-- Label Text -->
    <text>
    <name>LabelText</name>
    <type type="string">literal</type>
    <text type="string">{instrument + file}</text>
    <draw-text type="bool">true</draw-text>
    <font>Helvetica.txf</font>
    <character-size type="double">0.012</character-size>
    <character-aspect-ratio type="double">1.0</character-aspect-ratio>
    <axis-alignment>yz-plane</axis-alignment>
    <max-height>0.2</max-height>
    <max-width>0.07</max-width>
    <font-resolution>
        <width type="int">32</width>
        <height type="int">32</height>
    </font-resolution>
    <alignment>center-center</alignment>
    <offsets>
        <x-m> 0.01</x-m>
        <y-m> 0.0 </y-m>
        <z-m> 0.0</z-m>
    </offsets>
    </text>
    <animation>
    <type>material</type>
        <object-name>LabelText</object-name>
    <emission>
        <red>1.0</red>
        <green>1.0</green>
        <blue>0.0</blue>
    </emission>
</animation>
<animation>
    <type>select</type>
        <object-name>LabelText</object-name>
    <condition>
        <property>/sim/panel-hotspots</property>
    </condition>
</animation>
        '''
        with open("Instruments-3d"+"/"+instrument+"/"+file, "w") as f:
            f.write(text[:symb_num]+paste_text+text[symb_num:])
            print('done')