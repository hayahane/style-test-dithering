using Godot;

[Tool]
[GlobalClass]
public partial class PropertyTestCsharp: Node3D
{
    private bool _holdingHammer;

    [Export]
    public bool HoldingHammer
    {
        get => _holdingHammer;
        set
        {
            _holdingHammer = value;
            NotifyPropertyListChanged();
        }
    }

    public int HammerType { get; set; }

    public override Godot.Collections.Array<Godot.Collections.Dictionary> _GetPropertyList()
    {
        // 默认情况下，`HammerType` 在编辑器中不可见。
        var propertyUsage = PropertyUsageFlags.NoEditor;

        if (HoldingHammer)
        {
            propertyUsage = PropertyUsageFlags.Default;
        }

        var properties = new Godot.Collections.Array<Godot.Collections.Dictionary>();
        properties.Add(new Godot.Collections.Dictionary()
        {
            { "name", "HammerType" },
            { "type", (int)Variant.Type.Int },
            { "usage", (int)propertyUsage }, // 参见上面的赋值。
            { "hint", (int)PropertyHint.Enum },
            { "hint_string", "Wooden,Iron,Golden,Enchanted" }
        });

        return properties;
    }
}