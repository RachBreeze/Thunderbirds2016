namespace DataTidy
{
    partial class DataTidyForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.LatLong = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // LatLong
            // 
            this.LatLong.Location = new System.Drawing.Point(69, 25);
            this.LatLong.Name = "LatLong";
            this.LatLong.Size = new System.Drawing.Size(132, 23);
            this.LatLong.TabIndex = 0;
            this.LatLong.Text = "Set Lat Long";
            this.LatLong.UseVisualStyleBackColor = true;
            this.LatLong.Click += new System.EventHandler(this.LatLong_Click);
            // 
            // DataTidy
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 261);
            this.Controls.Add(this.LatLong);
            this.Name = "DataTidy";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button LatLong;
    }
}

