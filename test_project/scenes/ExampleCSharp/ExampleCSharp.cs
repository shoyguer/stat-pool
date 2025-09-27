// MIT License
// Copyright (c) 2025 Lucas "Shoyguer" Melo

using Godot;

public partial class ExampleCSharp : Node2D
{
	/// <summary>
	/// Test scene for StatPool functionality demonstration.
	/// StatPool instance for testing operations.
	/// </summary>
	private Resource statPool = null;

	/// <summary>
	/// Runs StatPool tests and creates health example.
	/// </summary>
	public override void _Ready()
	{
		// Try to create StatPool using ClassDB
		statPool = ClassDB.Instantiate("StatPool").As<Resource>();
		
		ConnectSignals();
		RunTests();
		CreateHealthExample();
	}

	/// <summary>
	/// Connects StatPool signals.
	/// </summary>
	private void ConnectSignals()
	{
		if (statPool == null) return;
		
		statPool.Connect("value_changed", new Callable(this, nameof(OnValueChanged)));
		statPool.Connect("depleted", new Callable(this, nameof(OnDepleted)));
		statPool.Connect("restored", new Callable(this, nameof(OnRestored)));
		statPool.Connect("restored_fully", new Callable(this, nameof(OnRestoredFully)));
	}

	/// <summary>
	/// Runs comprehensive StatPool tests.
	/// </summary>
	private void RunTests()
	{
		if (statPool == null) return;
		
		GD.Print("StatPool Test Suite");
		PrintStatus("Initial state");
		
		GD.Print("\nTesting value modifications...");
		statPool.Call("decrease", 30);
		PrintStatus($"After decreasing by {30}");
		
		statPool.Call("increase", 15);
		PrintStatus($"After increasing by {15}");
		
		GD.Print("\nTesting boundaries...");
		statPool.Call("deplete");
		PrintStatus("After deplete()");
		
		statPool.Call("increase", 25);
		PrintStatus($"After restoring by {25}");
		
		statPool.Call("fill");
		PrintStatus("After fill()");
		
		GD.Print("\nTesting range changes...");
		statPool.Call("set_max_value", 150);
		PrintStatus("Max changed to 150");
		
		GD.Print("\nTESTS COMPLETED!");
	}

	/// <summary>
	/// Creates health stat example.
	/// </summary>
	private void CreateHealthExample()
	{
		Resource health = ClassDB.Instantiate("StatPool").As<Resource>();
		if (health == null)
		{
			GD.PrintErr("Failed to create health StatPool instance");
			return;
		}
		
		health.Set("min_value", 0);
		health.Set("max_value", 200);
		health.Set("value", 150);
		
		GD.Print($"\nHealth example: {health.Call("get_value")}/{health.Call("get_max_value")} HP");
		GD.Print(health.Call("get_min_value"));
		GD.Print(health.Call("get_max_value"));
		health.Call("set_max_value", 150);
		GD.Print(health.Call("get_max_value"));
	}

	/// <summary>
	/// Prints current StatPool status.
	/// </summary>
	private void PrintStatus(string label)
	{
		if (statPool == null) return;
		
		int current = statPool.Call("get_value").AsInt32();
		float percentage = statPool.Call("get_percentage").AsSingle() * 100;
		string status;
		
		if (statPool.Call("is_depleted").AsBool())
		{
			status = "EMPTY";
		}
		else if (statPool.Call("is_filled").AsBool())
		{
			status = "FULL";
		}
		else
		{
			status = "PARTIAL";
		}
		
		GD.Print($"  {label}: {current} ({percentage:F0}%) [{status}]");
	}

	#region Signal Handlers
	/// <summary>
	/// Handles value changes.
	/// </summary>
	private void OnValueChanged(int oldValue, int newValue, bool increased)
	{
		string direction = increased ? "↑" : "↓";
		int change = Mathf.Abs(newValue - oldValue);
		GD.Print($"  {direction} Value changed by {change}: {oldValue} → {newValue}");
	}

	/// <summary>
	/// Handles stat depletion.
	/// </summary>
	private void OnDepleted(Resource stat)
	{
		GD.Print("Stat depleted!");
	}

	/// <summary>
	/// Handles restoration from minimum.
	/// </summary>
	private void OnRestored(Resource stat)
	{
		GD.Print("Restored from empty!");
	}

	/// <summary>
	/// Handles full restoration.
	/// </summary>
	private void OnRestoredFully(Resource stat)
	{
		GD.Print("Fully restored!");
	}
	#endregion
}