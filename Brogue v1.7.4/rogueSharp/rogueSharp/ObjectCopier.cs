using System;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Reflection;


/// <summary>
/// Reference Article http://www.codeproject.com/KB/tips/SerializedObjectCloner.aspx
/// Provides a method for performing a deep copy of an object.
/// Binary Serialization is used to perform the copy.
/// </summary>
public static class ObjectCopier
{
	/// <summary>
	/// Perform a deep Copy of the object.
	/// </summary>
	/// <typeparam name="T">The type of object being copied.</typeparam>
	/// <param name="source">The object instance to copy.</param>
	/// <returns>The copied object.</returns>
	public static T Clone<T>(T source)
	{
		if (!typeof(T).IsSerializable)
		{
			throw new ArgumentException("The type must be serializable.", "source");
		}

		// Don't serialize a null object, simply return the default for that object
		if (Object.ReferenceEquals(source, null))
		{
			return default(T);
		}

		IFormatter formatter = new BinaryFormatter();
		Stream stream = new MemoryStream();
		using (stream)
		{
			formatter.Serialize(stream, source);
			stream.Seek(0, SeekOrigin.Begin);
			return (T)formatter.Deserialize(stream);
		}
	}

	// dst <- source 
	public static T1 CopyFrom<T1>(this T1 obj, T1 otherObject)
		where T1: class
		//where T2: class
	{
		//Debug.Log ( "copy " + otherObject.GetType() );

		{
			PropertyInfo[] srcFields = otherObject.GetType ().GetProperties (
			//BindingFlags.Instance | BindingFlags.Public | BindingFlags.GetProperty
			                          );

			PropertyInfo[] destFields = obj.GetType ().GetProperties (
			//BindingFlags.Instance | BindingFlags.Public | BindingFlags.SetProperty
			                           );


			foreach (var property in srcFields) {
				//Debug.Log ("\t try copy " + property.ToString ());
				var dest = System.Linq.Enumerable.FirstOrDefault (destFields, x => x.Name == property.Name);
				if (dest != null && dest.CanWrite) {
					dest.SetValue (obj, property.GetValue (otherObject, null), null);
					//Debug.Log ("\t\tcopied ! ");
				}else {
					Debug.LogError ( string.Format( "{0}.{1} copy failed !!! " , otherObject.GetType() ,  property.ToString () ) );
				}
			}
		}


		//*
		{
			FieldInfo[] srcFields = otherObject.GetType().GetFields  (
				//BindingFlags.Instance | BindingFlags.Public | BindingFlags.GetProperty
			);

			FieldInfo[] destFields = obj.GetType ().GetFields  (
				//BindingFlags.Instance | BindingFlags.Public | BindingFlags.SetProperty
			);


			foreach (var property in srcFields) {
				//Debug.Log ("\t try copy " + property.ToString ());
				var dest = System.Linq.Enumerable.FirstOrDefault (destFields, x => x.Name == property.Name);
				if (dest != null) {
					dest.SetValue (obj, property.GetValue (otherObject));
					//Debug.Log ("\t\tcopied ! ");
				} else {
					Debug.LogError ( string.Format( "{0}.{1} copy failed !!! " , otherObject.GetType() ,  property.ToString () ) );
				}
			}
		}
		//*/

		return obj;
	}
}