using Godot;
using Godot.Collections;

[Tool]
[GlobalClass]
public partial class CsharpTestNode : Node3D
{
	private bool _isRotating;
	[Export]
	public bool IsRotating { get => _isRotating;
		set { _isRotating = value; NotifyPropertyListChanged(); }
	}
	public float RotateSpeed;
	public Vector3 RotateAxis;

	public override Array<Dictionary> _GetPropertyList()
	{
		var propertyUsage = PropertyUsageFlags.NoEditor;
		if (IsRotating) propertyUsage = PropertyUsageFlags.Default;
		var properties = new Array<Dictionary>();
		properties.Add(new Dictionary()
		{
			{"name", "RotateSpeed"},
			{"type", (int)Variant.Type.Float},
			{"usage",(int)propertyUsage}
		});
		properties.Add(new Dictionary()
		{
			{"name", "RotateAxis"},
			{"type", (int)Variant.Type.Vector3},
			{"usage", (int)propertyUsage}
		});

		return properties;
	}

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("C# Custom Node Ready");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		Transform = Transform.Rotated(RotateAxis, (float)delta * RotateSpeed);
		GD.Print((IsRotating?"is":"not") + " rotating");
	}
}
