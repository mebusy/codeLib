
using System;
using System.Reflection;
//using System.Collections;

public interface ISingleton {

}

public abstract class Singleton<T> : ISingleton where T : class
{
	private static T instance;
	private static object _lock = new object();
	protected Singleton () {}
	public static T GetInstance()
	{
		if(null == instance) {
			lock(_lock) {
				if (null == instance) {
					Type type = typeof(T);
					ConstructorInfo ctor;
					ctor = type.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic,
						null, new Type[0], new ParameterModifier[0]);
					instance = (T)ctor.Invoke(new object[0]);
				}
			}
		}
		return instance;
	}
}
