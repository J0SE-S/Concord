﻿using UnityEditor;
using UnityEngine;

namespace Dissonance.Editor.Windows.Welcome
{
    internal class WelcomeWindow
        : BaseDissonanceEditorWindow
    {
        #region constants
        private const float WindowWidth = 300f;
        private const float WindowHeight = 712f;
        private static readonly Vector2 WindowSize = new Vector2(WindowWidth, WindowHeight);

        private const string Title = "Welcome To Dissonance";
        #endregion

        #region construction
        public static void ShowWindow()
        {
            var window = GetWindow<WelcomeWindow>(true, Title, true);

            window.minSize = WindowSize;
            window.maxSize = WindowSize;
            window.titleContent = new GUIContent(Title);

            window.position = new Rect(150, 150, WindowSize.x, WindowSize.y);
            window.Repaint();
        }
        #endregion

        protected override void DrawContent()
        {
            EditorGUILayout.LabelField("Thankyou for installing Dissonance Voice Chat!", LabelFieldStyle);
            EditorGUILayout.LabelField($"Version {DissonanceComms.Version}", LabelFieldStyle);

            EditorGUILayout.LabelField("", LabelFieldStyle);

            if (GUILayout.Button("Before you can use Dissonance you will need to choose which network backend to use. Learn more about these options and which one you should choose <b><color=#aaaaff>here</color></b>.", LabelFieldStyle))
                Application.OpenURL("https://placeholder-software.co.uk/dissonance/docs/Basics/Choosing-A-Network.html");

            NetworkIntegrationButton("Mirror Networking",             "https://assetstore.unity.com/packages/slug/143290");
            NetworkIntegrationButton("Unity Netcode For GameObjects", "https://assetstore.unity.com/packages/slug/206514");
            NetworkIntegrationButton("Dark Rift 2",                   "https://assetstore.unity.com/packages/slug/143293");
            NetworkIntegrationButton("Forge Remastered",              "https://assetstore.unity.com/packages/slug/143286");
            NetworkIntegrationButton("Photon Unity Networking 2",     "https://assetstore.unity.com/packages/slug/143288");
            NetworkIntegrationButton("Photon BOLT",                   "https://assetstore.unity.com/packages/slug/143291");
            NetworkIntegrationButton("Steamworks.NET (P2P)",          "https://assetstore.unity.com/packages/slug/143292");
            NetworkIntegrationButton("WebRTC Network",                "https://assetstore.unity.com/packages/slug/143294");
            NetworkIntegrationButton("TNet3",                         "https://assetstore.unity.com/packages/slug/154374");
            NetworkIntegrationButton("UNet HLAPI",                    "https://assetstore.unity.com/packages/slug/143285");
            NetworkIntegrationButton("Custom Network Backend",        "https://placeholder-software.co.uk/dissonance/docs/Tutorials/Custom-Networking.html");

            EditorGUILayout.LabelField("", LabelFieldStyle);

            EditorGUILayout.LabelField("Set up instant lip sync for Dissonance speakers with SALSA lip sync.", LabelFieldStyle);
            NetworkIntegrationButton("SALSA Lip Sync", "https://crazyminnowstudio.com/unity-3d/lip-sync-salsa/downloads/");

            EditorGUILayout.LabelField("", LabelFieldStyle);

            EditorGUILayout.LabelField("Lower latency and higher quality microphone input with alternative recording systems.", LabelFieldStyle);
            NetworkIntegrationButton("FMOD Recording", "https://assetstore.unity.com/packages/slug/213412");

            EditorGUILayout.LabelField("", LabelFieldStyle);

            EditorGUILayout.LabelField("Audio output through the FMOD API.", LabelFieldStyle);
            NetworkIntegrationButton("FMOD Playback", "https://assetstore.unity.com/packages/slug/213415");
        }

        private static void NetworkIntegrationButton(string name, string url)
        {
            if (GUILayout.Button(name))
                Application.OpenURL($"{url}?aid=1100lJDF");
        }
    }
}